{ pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/virtualisation/proxmox-lxc.nix") ];

  proxmoxLXC = {
    # manageNetwork = false;
    # privileged = false;
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  environment.systemPackages = with pkgs; [ git ];

  networking.hostName = "dublin";

  services.openssh = {
    enable = true;

    # require public key authentication for better security
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  virtualisation.docker.enable = true;

  programs.zsh.enable = true;
  programs.neovim.defaultEditor = true;

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

  # Auto delete old generations
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 7d";

  system.stateVersion = "23.11";
}
