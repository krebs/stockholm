# puyak secrets

Secrets live in `pass` under `krebs-secrets/puyak` and are copied verbatim to
`/var/src/secrets` on the target by `nix run .#populate-secrets -- puyak`.
They are all consumed **at runtime** (activation / service start) — nothing is
read during `nixos-rebuild --flake` evaluation, so a pure build needs no
secrets.

## New / renamed by the krops→flake migration

These MUST be created in `pass` before the next deploy (the old files are no
longer read):

| file at /var/src/secrets | replaces | format |
|---|---|---|
| `hashedPassword.root` | `hashedPasswords.nix` | single line: the root password hash (`$6$...`) |
| `grafana/admin_user` | `grafana_security.nix` (`adminUser`) | single line |
| `grafana/admin_password` | `grafana_security.nix` (`adminPassword`) | single line |
| `grafana/secret_key` | *(new — grafana now requires it)* | single line, random ≥32 chars |

Migration (run locally with `PASSWORD_STORE_DIR=~/brain`):

```sh
# root password hash: extract the value from the old attrset file
pass show krebs-secrets/puyak/hashedPasswords.nix   # -> { root = "$6$..."; }
printf '%s' '$6$...' | pass insert -m krebs-secrets/puyak/hashedPassword.root

# grafana: split the old attrset into per-key files, generate a secret_key
pass show krebs-secrets/puyak/grafana_security.nix  # -> { adminUser=..; adminPassword=..; }
printf '%s' 'ADMIN_USER'     | pass insert -m krebs-secrets/puyak/grafana/admin_user
printf '%s' 'ADMIN_PASSWORD' | pass insert -m krebs-secrets/puyak/grafana/admin_password
pass generate krebs-secrets/puyak/grafana/secret_key 40
```

`grafana` reads `admin_user` / `admin_password` / `secret_key` at start via its
`$__file{}` provider (see `krebs/2configs/shack/grafana.nix`).

The `unifi` prometheus exporter (currently disabled in
`krebs/2configs/shack/prometheus/unifi.nix`) expects
`shack/unifi-prometheus-env` (an `EnvironmentFile`, e.g.
`UNIFI_PASSWORD=...`) if re-enabled — the old `shack/unifi-prometheus-pw`
plain file is no longer used.

## Runtime files (copied as-is from pass, unchanged)

`ssh.id_ed25519`, `retiolum.rsa_key.priv`, `syncthing.cert`, `syncthing.key`,
`initrd/*` (tor remote-unlock: `openssh_host_ecdsa_key`, `hs_ed25519_*`,
`hostname`, …), `hass/darksky.apikey`, `news.sync.key`, `repo-sync.ssh.key`,
`shack/muell_mail.js`, `shack/s3-power.json`, `shack/telegram_bot.env`,
`buildbot/nix-worker-file`, `shackspace-gitlab-ci`, `tell.json`,
`krebs-alerts@hackint.org`.
