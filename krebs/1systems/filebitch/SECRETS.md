# filebitch secrets

Secrets live in `pass` under `krebs-secrets/filebitch` and are copied verbatim
to `/var/src/secrets` by `nix run .#populate-secrets -- filebitch`. All are
consumed **at runtime**; a pure build needs no secrets.

## New / renamed by the krops→flake migration

filebitch imports `secret-passwords.nix`, so the root password hash is now read
from a file at runtime:

| file at /var/src/secrets | replaces | format |
|---|---|---|
| `hashedPassword.root` | `hashedPasswords.nix` | single line: the root password hash (`$6$...`) |

Migration:

```sh
pass show krebs-secrets/filebitch/hashedPasswords.nix   # -> { root = "$6$..."; }
printf '%s' '$6$...' | pass insert -m krebs-secrets/filebitch/hashedPassword.root
```

## Runtime files (copied as-is from pass, unchanged)

`ssh.id_ed25519`, `retiolum.ed25519_key.priv`, `retiolum.rsa_key.priv`.
