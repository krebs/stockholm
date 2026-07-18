# Systems: breaking changes & new usage

Record of deprecation fixes applied across the flake hosts and any operational
changes they imply. Newest first.

## Deprecation sweep (nixpkgs 26.05)

Evaluated every host in `flake.nix` and cleared renamed/removed NixOS options.
Most were mechanical option renames with no runtime impact:

| Old option | New option |
| --- | --- |
| `nix.maxJobs` | `nix.settings.max-jobs` |
| `nix.binaryCaches` | `nix.settings.substituters` |
| `nix.binaryCachePublicKeys` | `nix.settings.trusted-public-keys` |
| `boot.tmpOnTmpfs` | `boot.tmp.useTmpfs` |
| `services.samba.shares.<name>` | `services.samba.settings.<name>` |
| `services.knot.extraConfig` | `services.knot.settingsFile` (via `pkgs.writeText`) |
| `services.logind.lidSwitch` | `services.logind.settings.Login.HandleLidSwitch` |
| `services.logind.lidSwitchExternalPower` | `services.logind.settings.Login.HandleLidSwitchExternalPower` |
| `services.influxdb.extraConfig` | `services.influxdb.settings` |
| `hardware.opengl.enable` | `hardware.graphics.enable` |
| `hardware.opengl.extraPackages` | `hardware.graphics.extraPackages` |
| `services.nixosManual.enable` | `documentation.nixos.enable` |

Other fixes:

- `krebs/2configs/cal.nix` (hotdog): pinned `services.radicale.package = pkgs.radicale`
  to acknowledge the current 3.x storage/config format.
- `krebs/1systems/onebutton/config.nix`: `mpc-booter.service` now `wants`
  `network-online.target` (was only ordered `after` it).

### Behavioural notes

- `services.knot`: config is now materialised to a file with
  `pkgs.writeText "knot.conf"` and passed as `settingsFile`. Combined with
  `keyFiles`, this disables build-time config checks (expected).
- `services.samba`: per-share sections moved under `settings` alongside
  `settings.global`; wire semantics unchanged.

## GitLab CI runner — DISABLED

**Breaking change.** The shackspace GitLab runner is disabled on `wolf` and
`puyak`. The import of `krebs/2configs/shack/gitlab-runner.nix` is commented out
in both host configs.

Reason: the module still uses `registrationConfigFile` with a
`REGISTRATION_TOKEN`. Registration tokens are deprecated and disabled by default
in GitLab >= 17.0. The existing secret (`shackspace-gitlab-ci`, `CI_SERVER_URL`
+ `REGISTRATION_TOKEN`) no longer works; the runner on puyak was already
`inactive`.

### To re-enable

1. In the shackspace GitLab UI, create a runner and obtain a runner
   **authentication token** (`glrt-…`).
2. Store a new secret file containing `CI_SERVER_URL` and `CI_SERVER_TOKEN`.
3. In `krebs/2configs/shack/gitlab-runner.nix`, replace
   `registrationConfigFile` with
   `services.gitlab-runner.services.nix.authenticationTokenConfigFile`.
4. Uncomment the import in the affected host config(s).

See <https://docs.gitlab.com/17.0/ee/ci/runners/new_creation_workflow.html>.

## puyak — tor remote LUKS unlock in initrd

`krebs/2configs/tor/initrd.nix` still runs on **scripted stage-1**, pinned via
`boot.initrd.systemd.enable = lib.mkForce false`. Scripted initrd is deprecated
in nixpkgs (removal scheduled for 26.11). A fully worked-out systemd stage-1
replacement lives in the same file as a documented, commented-out block.

It is **not** enabled: puyak is remote, and a broken initrd cannot be unlocked
or reached. Enable and verify with serial/IPMI console access before relying on
it.

### Current usage (scripted stage-1, ACTIVE)

Unlock over the onion service by writing the passphrase to the FIFO:

```sh
(brain hosts/puyak/luks-ssd; echo) \
  | ssh root@$(brain krebs-secrets/puyak/initrd/hostname) 'cat > /crypt-ramfs/passphrase'
```

### New usage after migrating to systemd stage-1

**Breaking change in the unlock procedure.** systemd stage-1 uses
`systemd-ask-password`, not the `/crypt-ramfs/passphrase` FIFO. Unlock becomes
interactive (needs a pty via `-t`):

```sh
ssh -t root@$(brain krebs-secrets/puyak/initrd/hostname) systemd-tty-ask-password-agent
# then paste: brain hosts/puyak/luks-ssd
```

For a non-interactive pipe, reply directly to the socket advertised in
`/run/systemd/ask-password/ask.*`.

Migration steps are documented inline in `krebs/2configs/tor/initrd.nix`:
remove the scripted block (the `mkForce false` pin, `extraUtilsCommands`,
`network.postCommands`) and uncomment the systemd block, which runs tor as a
real `boot.initrd.systemd.services.tor` unit (mirroring the upstream
`boot.initrd.network.openvpn` module).
