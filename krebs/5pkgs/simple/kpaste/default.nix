{ curl, gnused, writeDashBin }:

writeDashBin "kpaste" ''
  ${curl}/bin/curl -sS http://p.r --data-binary @"''${1:--}" |
  ${gnused}/bin/sed '$ {p;s/\<http://p.r\>/krebsco.de/}'
''
