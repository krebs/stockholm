{ pkgs, lib, writeDash, ... }:

let
  stockholm.lib = import ../../../../lib/pure.nix { inherit lib; };
  inherit (stockholm.lib) makeBinPath;
in

pkgs.runCommand "irc-announce-git-hook" {} ''
  mkdir -p $out/bin
  cat > $out/bin/irc-announce-git-hook << 'OUTER'
#!${pkgs.dash}/bin/dash
set -euf

# Required environment variables:
# IRC_SERVER, IRC_PORT, IRC_NICK, IRC_CHANNEL
# Optional: IRC_TLS (set to "true" for TLS), CGIT_ENDPOINT, VERBOSE

export PATH=${makeBinPath (with pkgs; [
  coreutils
  git
  gnugrep
  gnused
])}:$PATH

green()  { printf '\x0303,99%s\x0F' "$1"; }
red()    { printf '\x0304,99%s\x0F' "$1"; }
orange() { printf '\x0307,99%s\x0F' "$1"; }
pink()   { printf '\x0313,99%s\x0F' "$1"; }
gray()   { printf '\x0314,99%s\x0F' "$1"; }

unset message
add_message() {
  message="''${message+$message
}$*"
}

empty=0000000000000000000000000000000000000000

while read oldrev newrev ref; do

  if [ $oldrev = $empty ]; then
    receive_mode=create
  elif [ $newrev = $empty ]; then
    receive_mode=delete
  elif [ "$(git merge-base $oldrev $newrev)" = $oldrev ]; then
    receive_mode=fast-forward
  else
    receive_mode=non-fast-forward
  fi

  h=$(echo $ref | sed 's:^refs/heads/::')

  empty_tree=4b825dc6

  id=$(echo $newrev | cut -b-7)
  id2=$(echo $oldrev | cut -b-7)
  if [ $newrev = $empty ]; then id=$empty_tree; fi
  if [ $oldrev = $empty ]; then id2=$empty_tree; fi

  if [ -n "''${CGIT_ENDPOINT:-}" ]; then
    case $receive_mode in
      create)
        link="$CGIT_ENDPOINT/$GIT_SSH_REPO/?h=$h"
        ;;
      delete)
        link="$CGIT_ENDPOINT/$GIT_SSH_REPO/ ($h)"
        ;;
      fast-forward|non-fast-forward)
        link="$CGIT_ENDPOINT/$GIT_SSH_REPO/diff/?h=$h&id=$id&id2=$id2"
        ;;
    esac
  else
    link="$GIT_SSH_REPO $h"
  fi

  add_message $(pink push) $link $(gray "($receive_mode)")

  if [ "''${VERBOSE:-}" = "true" ]; then
    add_message "$(
      git log \
          --format="$(orange %h) %s $(gray '(%ar)')" \
          --no-merges \
          --reverse \
          $id2..$id

      git diff --stat $id2..$id \
        | sed '$!s/\(+*\)\(-*\)$/'"$(green '\1')$(red '\2')"'/'
    )"
  fi

done

if test -n "''${message-}"; then
  tls_flag=""
  if [ "''${IRC_TLS:-}" = "true" ]; then
    tls_flag="1"
  fi
  exec ${pkgs.irc-announce}/bin/irc-announce \
    "$IRC_SERVER" \
    "$IRC_PORT" \
    "$IRC_NICK" \
    "$IRC_CHANNEL" \
    "$tls_flag" \
    "$message"
fi
OUTER
  chmod +x $out/bin/irc-announce-git-hook
''
