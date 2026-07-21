# Loads host and user data from the kartei submodule (plain file tree,
# generic key material only) and overlays stockholm-specific policy from
# ./overlay.nix: via routes, ip prefixes, dns, sitemap, host flags,
# extraZones, ssh privkey locations and uid assignments.
{ config, lib, ... }:
let
  data = import ../../../kartei;
  overlay = import ./overlay.nix;

  mergeHost = name: host:
    let
      ov = overlay.hosts.${name} or { };
      nets = lib.mapAttrs
        (netname: net:
          let nov = ov.nets.${netname} or { }; in
          lib.recursiveUpdate net (removeAttrs nov [ "via" ])
          // lib.optionalAttrs (nov ? via) { via = nets.${nov.via}; })
        host.nets;
    in
    removeAttrs host [ "owner" "nets" ]
    // removeAttrs ov [ "nets" "ssh" ]
    // {
      # hosts may be owned by users without any kartei record; the
      # krebs.users type fills in all defaults from the name alone
      owner = config.krebs.users.${host.owner} or { name = host.owner; };
      inherit nets;
    }
    // lib.optionalAttrs (host ? ssh || ov ? ssh)
      { ssh = host.ssh or { } // ov.ssh or { }; };
in
{
  krebs = {
    hosts = lib.mapAttrs mergeHost data.hosts;
    users = lib.recursiveUpdate data.users overlay.users;
    dns.providers = overlay.dns.providers;
    sitemap = lib.mapAttrs (_: e: { inherit (e) desc; }) overlay.sitemap;
  };
}
