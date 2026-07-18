# ponte secrets

Secrets live in `pass` under `krebs-secrets/ponte` and are copied verbatim to
`/var/src/secrets` by `nix run .#populate-secrets -- ponte`. All are consumed
**at runtime**; a pure `nixos-rebuild --flake .#ponte build` needs no secrets.

## Changed consumption by the krops→flake migration

No new files are required, but two secrets are now read at runtime instead of
eval time:

| file at /var/src/secrets | consumer | format |
|---|---|---|
| `telegram.token` | matterbridge (rendered into `/run/matterbridge/config.toml` via systemd `LoadCredential`) | single line bot token |
| `acme-credentials` | ACME `environmentFile` for the rfc2136 DNS provider | env vars (`RFC2136_*`) |

`telegram.token` and `acme-credentials` already exist in `pass` with the right
format — no migration needed.

Note: ponte does not import `secret-passwords.nix`, so its
`hashedPasswords.nix` in `pass` is unused (root has no file-based password
here). Nothing to migrate.

## Runtime files (copied as-is from pass, unchanged)

`ssh.id_ed25519`, `retiolum.ed25519_key.priv`, `retiolum.rsa_key.priv`,
`knot-keys.conf`, `dane.tsig`, `ed25519_key.pub`, `rsa_key.pub`,
`ssh.id_ed25519.pub`.
