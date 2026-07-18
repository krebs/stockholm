# wolf secrets

Secrets live in `pass` under `krebs-secrets/wolf` and are copied verbatim to
`/var/src/secrets` by `nix run .#populate-secrets -- wolf`. All are consumed
**at runtime**; a pure build needs no secrets.

## Migration notes

wolf's current config imports no eval-time-secret modules (no grafana, no
matterbridge, no unifi), so **no new files are required**.

If grafana or the unifi exporter are later enabled on wolf, follow the puyak
doc: split `grafana_security.nix` into `grafana/admin_user`,
`grafana/admin_password`, `grafana/secret_key`, and convert
`shack/unifi-prometheus-pw` into `shack/unifi-prometheus-env`
(`UNIFI_PASSWORD=...`).

## Runtime files (copied as-is from pass, unchanged)

`ssh.id_ed25519`, `retiolum.rsa_key.priv`, `retiolum-ci.rsa_key.priv`,
`repo-sync.rsa_key.priv`, `repo-sync.ssh.key`, `wolf-repo-sync.rsa_key.priv`,
`hass/darksky.apikey`, `shack/muell_mail.js`, `shack/s3-power.json`,
`shackspace-gitlab-ci`, `cac`, `cac.json`, `tell.json`.
