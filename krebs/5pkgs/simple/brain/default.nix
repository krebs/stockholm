{ pkgs }:

let
  pass = pkgs.pass.withExtensions (ext: [
    ext.pass-otp
  ]);

  brain = pkgs.writeDash "brain" ''
    PASSWORD_STORE_DIR=$HOME/brain \
    exec ${pass}/bin/pass "$@"
  '';

  brainmenu = pkgs.writeDash "brainmenu" ''
    PASSWORD_STORE_DIR=$HOME/brain \
    exec ${pass}/bin/passmenu "$@"
  '';

  completions = pkgs.runCommand "brain-completions" {} ''
    sed -r '
      s/\<_pass?(_|\>)/_brain\1/g
      s/\<__password_store/_brain/g
      s/\<pass\>/brain/
      s/\$HOME\/\.password-store/$HOME\/brain/
    ' < ${pass}/share/bash-completion/completions/pass > $out
  '';
in

pkgs.runCommand "brain" {} ''
  mkdir -p $out/bin $out/share/bash-completion/completions
  ln -s ${brain} $out/bin/brain
  ln -s ${brainmenu} $out/bin/brainmenu
  ln -s ${completions} $out/share/bash-completion/completions/brain
''
