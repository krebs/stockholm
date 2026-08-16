# krebs hosts

Deployable hosts: `filebitch`, `hotdog`, `onebutton` (armv6l), `ponte`,
`puyak`, `wolf`. The `test-*` directories are CI eval stubs and are not part of
`nixosConfigurations`.

The kartei submodule holds the host registry, so a fresh clone needs

    git submodule update --init

## build

    nix build .#nixosConfigurations.<host>.config.system.build.toplevel

## deploy

Two steps, because secrets are kept in pass and are therefore not part of the
flake.

1. copy the secrets:

       nix run .#populate-secrets -- <host> [target]

   krops decrypts `~/brain/krebs-secrets/<host>` and rsyncs it to
   `root@<target>:/var/src/secrets`, which is what `krebs.secret.directory`
   points at. The rsync runs with `--delete-excluded`, so the target directory
   is an exact mirror of the pass tree: removing an entry from pass removes it
   from the host on the next run.

2. build and activate:

       nixos-rebuild switch --flake .#<host> --target-host root@<host>

Step 1 is only needed when the secrets changed.

## secrets

No module may read a secret while evaluating -- that breaks pure evaluation and
copies the secret into the world-readable store. Reference the file path and let
the service read it at runtime instead: `hashedPasswordFile`, `passwordFile`,
`environmentFile`, grafana's `$__file{}`, systemd's `LoadCredential`.

Adding one means putting it in pass below `krebs-secrets/<host>/` and pointing
at `"${config.krebs.secret.directory}/<name>"` from the module.

## legacy full krops deploy

Before flakes the whole tree was shipped to the target and built there. Still
works, and still the only way to deploy without a flake:

    $(nix-build --no-out-link -A deploy --argstr name <host> ./krebs/krops.nix)

It rsyncs nixpkgs, stockholm and the secrets to `/var/src` and then runs
`nixos-rebuild switch` over ssh with `NIX_PATH=/var/src`.
