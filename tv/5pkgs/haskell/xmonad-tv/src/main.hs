{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE PatternSynonyms #-}

module Main (main) where

import System.Exit (exitFailure)
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.EwmhDesktops.Extra (ewmhExtra)
import XMonad.Hooks.RefocusLast (refocusLastLayoutHook, toggleFocus)

import Control.Monad.Extra (whenJustM)
import qualified Data.Aeson
import qualified Data.ByteString.Char8
import qualified Data.List
import qualified Data.Maybe
import Graphics.X11.ExtraTypes.XF86
import XMonad
import XMonad.Extra (isFloatingX)
import System.IO (hPutStrLn, stderr)
import System.Environment (getArgs, getEnv, getEnvironment, lookupEnv)
import System.Posix.Process (executeFile)
import XMonad.Actions.DynamicWorkspaces ( addWorkspacePrompt, renameWorkspace
                                        , removeEmptyWorkspace)
import XMonad.Actions.CycleWS (toggleWS)
import XMonad.Layout.Gaps (Direction2D(U,R,D,L), gaps)
import XMonad.Layout.NoBorders ( smartBorders )
import XMonad.Layout.ResizableTile (ResizableTall(ResizableTall))
import XMonad.Layout.ResizableTile (MirrorResize(MirrorExpand,MirrorShrink))
import XMonad.Layout.StateFull (pattern StateFull)
import qualified XMonad.Prompt
import qualified XMonad.StackSet as W
import Data.Map (Map)
import qualified Data.Map as Map
import XMonad.Hooks.UrgencyHook
  ( BorderUrgencyHook(BorderUrgencyHook,urgencyBorderColor)
  , RemindWhen(Dont)
  , SuppressWhen(Never)
  , UrgencyConfig(UrgencyConfig,remindWhen,suppressWhen)
  , withUrgencyHookC
  )
import XMonad.Hooks.ManageHelpers (doCenterFloat,doRectFloat)
import Data.Ratio
import XMonad.Hooks.Place (placeHook, smart)
import XMonad.Actions.PerWorkspaceKeys (chooseAction)

import Shutdown (shutdown, newShutdownEventHandler)


main :: IO ()
main = getArgs >>= \case
    [] -> mainNoArgs
    ["--shutdown"] -> shutdown
    args -> hPutStrLn stderr ("bad arguments: " <> show args) >> exitFailure


(=??) :: Query a -> (a -> Bool) -> Query Bool
(=??) x p = fmap p x

readEnv :: Data.Aeson.FromJSON b => String -> IO b
readEnv name =
    readEnv' (error $ "could not get environment variable: " <> name) name

readEnv' :: Data.Aeson.FromJSON b => b -> String -> IO b
readEnv' defaultValue name =
    Data.Maybe.fromMaybe defaultValue
      . Data.Aeson.decodeStrict'
      . Data.ByteString.Char8.pack
      . Data.Maybe.fromMaybe mempty
      <$> lookupEnv name

mainNoArgs :: IO ()
mainNoArgs = do
    myScreenGaps <- readEnv' [] "XMONAD_SCREEN_GAPS" :: IO [Int]
    myScreenWidth <- readEnv "XMONAD_SCREEN_WIDTH" :: IO Dimension
    myTermFont <- getEnv "XMONAD_TERM_FONT"
    myTermFontWidth <- readEnv "XMONAD_TERM_FONT_WIDTH" :: IO Dimension
    myTermPadding <- readEnv "XMONAD_TERM_PADDING" :: IO Dimension
    handleShutdownEvent <- newShutdownEventHandler
    config <-
      ewmhExtra
        $ ewmh
        $ withUrgencyHookC
            BorderUrgencyHook
              { urgencyBorderColor = "#ff0000"
              }
            UrgencyConfig
              { remindWhen = Dont
              , suppressWhen = Never
              }
        $ def
            { terminal          = {-pkg:alacritty-tv-}"alacritty"
            , modMask           = mod4Mask
            , keys              = myKeys myTermFont
            , layoutHook =
                refocusLastLayoutHook $
                gaps (zip [U,R,D,L] myScreenGaps) $
                smartBorders $
                  ResizableTall
                    1
                    (fromIntegral (10 * myTermFontWidth) / fromIntegral myScreenWidth)
                    (fromIntegral (80 * myTermFontWidth + 2 * (myTermPadding + borderWidth def)) / fromIntegral myScreenWidth)
                    []
                  |||
                  StateFull
            , manageHook =
                composeAll
                  [ appName =? "fzmenu-urxvt" --> doCenterFloat
                  , appName =?? Data.List.isPrefixOf "pinentry" --> doCenterFloat
                  , appName =?? Data.List.isInfixOf "Float" --> doCenterFloat
                  , title =? "Upload to Imgur" -->
                      doRectFloat (W.RationalRect 0 0 (1 % 8) (1 % 8))
                  , placeHook (smart (1,0))
                  ]
            , startupHook =
                whenJustM (io (lookupEnv "XMONAD_STARTUP_HOOK"))
                          (\path -> forkFile path [] Nothing)
            , normalBorderColor  = "#1c1c1c"
            , focusedBorderColor = "#f000b0"
            , handleEventHook = handleShutdownEvent
            }
    directories <- getDirectories
    launch config directories


forkFile :: FilePath -> [String] -> Maybe [(String, String)] -> X ()
forkFile path args env =
    xfork (executeFile path True args env) >> return ()


spawnRootTerm :: X ()
spawnRootTerm =
    forkFile
        {-pkg:alacritty-tv-}"alacritty"
        ["--profile=root", "-e", "/run/wrappers/bin/su", "-"]
        Nothing


myKeys :: String -> XConfig Layout -> Map (KeyMask, KeySym) (X ())
myKeys font conf = Map.fromList $
    [ ((_4  , xK_Escape ), forkFile {-pkg-}"slock" [] Nothing)
    , ((_4S , xK_c      ), kill)

    , ((_4  , xK_o      ), forkFile {-pkg:fzmenu-}"otpmenu" [] Nothing)
    , ((_4  , xK_p      ), forkFile {-pkg:fzmenu-}"passmenu" [] Nothing)

    , ((_4  , xK_x      ), forkFile {-pkg:alacritty-tv-}"alacritty" ["--singleton"] Nothing)
    , ((_4C , xK_x      ), spawnRootTerm)

    , ((_C  , xK_Menu   ), toggleWS)

    , ((_4  , xK_space  ), withFocused $ \w -> ifM (isFloatingX w) xdeny $ sendMessage NextLayout)
    , ((_4M , xK_space  ), withFocused $ \w -> ifM (isFloatingX w) xdeny $ resetLayout)

    , ((_4  , xK_l      ), toggleFocus)

    , ((_4  , xK_m      ), windows W.focusMaster)
    , ((_4  , xK_j      ), windows W.focusDown)
    , ((_4  , xK_k      ), windows W.focusUp)

    , ((_4S , xK_m      ), windows W.swapMaster)
    , ((_4S , xK_j      ), windows W.swapDown)
    , ((_4S , xK_k      ), windows W.swapUp)

    , ((_4M , xK_h      ), sendMessage Shrink)
    , ((_4M , xK_l      ), sendMessage Expand)

    , ((_4M , xK_j      ), sendMessage MirrorShrink)
    , ((_4M , xK_k      ), sendMessage MirrorExpand)

    , ((_4  , xK_t      ), withFocused $ windows . W.sink)

    , ((_4  , xK_comma  ), sendMessage $ IncMasterN 1)
    , ((_4  , xK_period ), sendMessage $ IncMasterN (-1))

    , ((_4  , xK_a      ), addWorkspacePrompt promptXPConfig)
    , ((_4  , xK_r      ), renameWorkspace promptXPConfig)
    , ((_4  , xK_Delete ), removeEmptyWorkspace)

    , ((_4  , xK_Return ), toggleWS)

    , ((0, xF86XK_AudioLowerVolume), audioLowerVolume)
    , ((0, xF86XK_AudioRaiseVolume), audioRaiseVolume)
    , ((0, xF86XK_AudioMute), audioMute)
    , ((0, xF86XK_AudioMicMute), audioMicMute)
    , ((_4, xF86XK_AudioMute), pavucontrol [])

    , ((_4, xK_Prior), forkFile {-pkg-}"xcalib" ["-invert", "-alter"] Nothing)

    , ((0, xK_Print), forkFile {-pkg:flameshot-once-tv-}"flameshot-once" [] Nothing)

    , ((_C, xF86XK_Forward), forkFile {-pkg:xdpytools-}"xdpychvt" ["next"] Nothing)
    , ((_C, xF86XK_Back), forkFile {-pkg:xdpytools-}"xdpychvt" ["prev"] Nothing)
    ]
    where
    _4 = mod4Mask
    _C = controlMask
    _S = shiftMask
    _M = mod1Mask
    _4C = _4 .|. _C
    _4S = _4 .|. _S
    _4M = _4 .|. _M
    _4CM = _4 .|. _C .|. _M
    _4SM = _4 .|. _S .|. _M

    amixer args = forkFile {-pkg:alsaUtils-}"amixer" args Nothing
    pavucontrol args = forkFile {-pkg-}"pavucontrol" args Nothing

    audioLowerVolume = amixer ["-q", "sset", "Master", "5%-"]
    audioRaiseVolume = amixer ["-q", "sset", "Master", "5%+"]
    audioMute = amixer ["-q", "sset", "Master", "toggle"]
    audioMicMute = amixer ["-q", "sset", "Capture", "toggle"]

    resetLayout = setLayout $ XMonad.layoutHook conf

    promptXPConfig =
        def { XMonad.Prompt.font = font }

    xdeny =
        forkFile
            {-pkg-}"xterm"
            [ "-fn", font
            , "-geometry", "300x100"
            , "-name", "AlertFloat"
            , "-bg", "#E4002B"
            , "-e", "sleep", "0.05"
            ]
            Nothing
