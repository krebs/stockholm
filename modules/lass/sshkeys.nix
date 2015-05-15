{ config, ... }:

{
  imports = [
    ../common/sshkeys.nix
  ];

  config.sshKeys.lass.pub = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAp83zynhIueJJsWlSEykVSBrrgBFKq38+vT8bRfa+csqyjZBl2SQFuCPo+Qbh49mwchpZRshBa9jQEIGqmXxv/PYdfBFQuOFgyUq9ZcTZUXqeynicg/SyOYFW86iiqYralIAkuGPfQ4howLPVyjTZtWeEeeEttom6p6LMY5Aumjz2em0FG0n9rRFY2fBzrdYAgk9C0N6ojCs/Gzknk9SGntA96MDqHJ1HXWFMfmwOLCnxtE5TY30MqSmkrJb7Fsejwjoqoe9Y/mCaR0LpG2cStC1+37GbHJNH0caCMaQCX8qdfgMVbWTVeFWtV6aWOaRgwLrPDYn4cHWQJqTfhtPrNQ== lass@mors";
}
