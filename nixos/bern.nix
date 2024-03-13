{ pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/virtualisation/lxc-container.nix") ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  environment.systemPackages = with pkgs; [ neovim git ];

  networking.hostName = "bern";

  virtualisation.docker.enable = true;

  programs.zsh.enable = true;

  users.users = {
    bondzula = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIa8ipSFMoDgS8u+AVtxeokw5OB4DvF86GFcZAzJ74Lk stefanbondzulic@gmail.com"
      ];
      extraGroups = [ "wheel" "docker" ];
      shell = pkgs.zsh;
    };
  };

  system.stateVersion = "23.11";
}
