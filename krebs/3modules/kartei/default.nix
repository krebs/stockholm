# Loads host and user data from the kartei submodule (plain file tree,
# generic key material only) and overlays stockholm-specific policy from
# ./overlay.nix: via routes, ip prefixes, dns, sitemap, host flags,
# extraZones, ssh privkey locations and uid assignments.
{ config, lib, ... }:
let
  data = import ../../../kartei { inherit lib; };
  overlay = import ./overlay.nix;

  mergeHost = name: host:
    let
      ov = overlay.hosts.${name} or { };
      nets = lib.mapAttrs
        (netname: net:
          let
            nov = ov.nets.${netname} or { };
            merged = lib.recursiveUpdate net (removeAttrs nov [ "via" ]);
          in
          merged
          // lib.optionalAttrs (nov ? via) ({
            via = nets.${nov.via};
          } // lib.optionalAttrs (merged.tinc != null) {
            # a via'd node is not directly reachable; let tinc measure
            # the route weight instead of kartei's static default
            tinc = merged.tinc // { weight = null; };
          }))
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
    // { ssh = host.ssh // ov.ssh or { }; };
in
{
  krebs = {
    hosts = lib.mapAttrs mergeHost data.hosts;
    # drop null fields so other modules (e.g. users.nix for the krebs
    # user) can define them without conflicting definitions
    users = lib.recursiveUpdate
      (lib.mapAttrs (_: lib.filterAttrs (_: v: v != null)) data.users)
      overlay.users;
    dns.providers = overlay.dns.providers;
    sitemap = lib.mapAttrs (_: e: { inherit (e) desc; }) overlay.sitemap;
  };
}
