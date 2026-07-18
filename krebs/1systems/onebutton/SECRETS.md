# onebutton secrets

Secrets live in `pass` under `krebs-secrets/onebutton` and are copied verbatim
to `/var/src/secrets` by `nix run .#populate-secrets -- onebutton`. All are
consumed **at runtime**; a pure build needs no secrets.

onebutton is `armv6l-linux` (RaspberryPi 1); building it on an x86_64 host
needs `binfmt`/qemu emulation. It is excluded from the x86_64 CI build set
(`ci.nix`).

## Migration notes

onebutton does not import `secret-passwords.nix`, so its `hashedPasswords.nix`
in `pass` is unused — nothing to migrate.

## Runtime files (copied as-is from pass, unchanged)

`ssh.id_ed25519`, `retiolum.rsa_key.priv`.
