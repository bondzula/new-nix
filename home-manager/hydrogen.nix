{ pkgs, ... }: 
let
  hmModules = import ./modules;
in
{
  # This is required information for home-manager to do its job
  home = {
    stateVersion = "23.11";
    username = "stefanbondzulic";
    homeDirectory = "/Users/stefanbondzulic";

    packages = with pkgs; [
    ];
  };

  imports = [
    hmModules.core

    hmModules.atuin
    hmModules.starship
    hmModules.wezterm
  ];

  programs.home-manager.enable = true;
}
