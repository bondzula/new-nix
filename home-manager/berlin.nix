{ pkgs, ... }:
let hmModules = import ./modules;
in {
  # This is required information for home-manager to do its job
  home = {
    stateVersion = "23.11";
    username = "bondzula";
    homeDirectory = "/home/bondzula";

    packages = with pkgs; [ tailscale wezterm ];
  };

  imports = [
    hmModules.core

    hmModules.wezterm
    # hmModules.atuin
    hmModules.starship
  ];

  programs.home-manager.enable = true;
}
