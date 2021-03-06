{ pkgs }:

pkgs.writeDashBin "pager" ''
  # usage: pager {view,shift,shiftview}
  #
  # Environment variables
  #
  #   PAGER_NAME (default: Pager)
  #     The environment variables specifies the application name under which
  #     resources are to be obtained.  PAGER_NAME should not contain “.” or “*”
  #     characters.
  #
  set -efu

  pidfile=$XDG_RUNTIME_DIR/pager.lock
  name=''${PAGER_NAME-Pager}

  if test -e "$pidfile" &&
     ${pkgs.procps}/bin/pgrep --pidfile="$pidfile" >/dev/null
  then
    ${pkgs.procps}/bin/pkill --pidfile="$pidfile"
    ${pkgs.coreutils}/bin/rm "$pidfile"
    exit
  fi

  echo $$ > "$pidfile"

  exec ${pkgs.xterm}/bin/xterm \
      -name "$name" \
      -ti vt340 \
      -xrm 'Pager*geometry: 32x10' \
      -xrm 'Pager*internalBorder: 2' \
      -xrm 'Pager*background: #050505' \
      -xrm 'Pager*foreground: #d0d7d0' \
      -e ${pkgs.haskellPackages.pager}/bin/pager "$@"
''
