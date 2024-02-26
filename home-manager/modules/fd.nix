# User configuration for fd
{ pkgs, ... }:

{
  # Install fd
  home.packages = with pkgs; [ fd ];

  # Default options
  programs.zsh.shellAliases = { fd = "fd --hidden"; };
}
