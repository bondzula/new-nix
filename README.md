## Setup

- First install nix

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

- Create a nix configuration to enable experimental features (flakes)

```bash
mkdir -p .config/nix
```

```bash
nvim .config/nix/nix.conf
```

And past the following in:

`experimental-features = nix-command flakes`

- Install this flake

```bash
nix run home-manager/master -- switch --flake github:bondzula/new-nix
```
