# hotdog secrets

hotdog is a container (`boot.isContainer`, `krebs.sync-containers3.inContainer`)
and imports no eval-time-secret modules, so a pure
`nixos-rebuild --flake .#hotdog build` needs no secrets and **no migration is
required**.

Its runtime secrets are delivered through the container sync flow into
`/var/src/secrets`, not by `populate-secrets`. For reference the expected files
(`pass krebs-secrets/hotdog`) are:

`ssh.id_ed25519`, `retiolum.ed25519_key.priv`, `retiolum.rsa_key.priv`,
`wirelum.key`, `acme_ca.key`, `github-hosts-sync.ssh.id_ed25519`,
`gollum.id_ed25519`, `konsens.id_ed25519`, `radicale.id_ed25519`,
`repo-sync.ssh.key`, `reaktor@hackint.org.json`,
`shackspace-gitlab-ci-token.nix`, `buildbot/*` (github-oauth-secret,
github-token, github-webhook-secret, nix-worker-file, nix-workers,
oauth-clientid).
