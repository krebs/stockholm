{
  services.openssh.knownHosts.github = {
    hostNames = [
      "github.com"
      # List generated with (IPv6 addresses are currently ignored):
      # curl -sS https://api.github.com/meta | jq -r .git[] | grep -v : | nix-shell -p cidr2glob --run cidr2glob | jq -R .
      "192.30.252.*"
      "192.30.253.*"
      "192.30.254.*"
      "192.30.255.*"
      "185.199.108.*"
      "185.199.109.*"
      "185.199.110.*"
      "185.199.111.*"
      "140.82.112.*"
      "140.82.113.*"
      "140.82.114.*"
      "140.82.115.*"
      "140.82.116.*"
      "140.82.117.*"
      "140.82.118.*"
      "140.82.119.*"
      "140.82.120.*"
      "140.82.121.*"
      "140.82.122.*"
      "140.82.123.*"
      "140.82.124.*"
      "140.82.125.*"
      "140.82.126.*"
      "140.82.127.*"
      "143.55.64.*"
      "143.55.65.*"
      "143.55.66.*"
      "143.55.67.*"
      "143.55.68.*"
      "143.55.69.*"
      "143.55.70.*"
      "143.55.71.*"
      "143.55.72.*"
      "143.55.73.*"
      "143.55.74.*"
      "143.55.75.*"
      "143.55.76.*"
      "143.55.77.*"
      "143.55.78.*"
      "143.55.79.*"
      "13.114.40.48"
      "52.192.72.89"
      "52.69.186.44"
      "15.164.81.167"
      "52.78.231.108"
      "13.234.176.102"
      "13.234.210.38"
      "13.236.229.21"
      "13.237.44.5"
      "52.64.108.95"
      "20.201.28.151"
      "20.205.243.166"
      "102.133.202.242"
      "20.248.137.48"
      "18.181.13.223"
      "54.238.117.237"
      "54.168.17.15"
      "3.34.26.58"
      "13.125.114.27"
      "3.7.2.84"
      "3.6.106.81"
      "52.63.152.235"
      "3.105.147.174"
      "3.106.158.203"
      "20.201.28.152"
      "20.205.243.160"
      "102.133.202.246"
      "20.248.137.50"
    ];
    publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==";
  };
}
