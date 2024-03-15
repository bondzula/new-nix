{ pkgs, modulesPath, hostname, ... }:

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

  networking.hostName = hostname;

  services.openssh = {
    enable = true;

    # require public key authentication for better security
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  services.caddy = {
    enable = true;
    package = pkgs.callPackage ./caddy/custom-caddy.nix {
      plugins = [
        "github.com/mholt/caddy-l4"
        "github.com/caddyserver/caddy/v2/modules/standard"
        "github.com/hslatman/caddy-crowdsec-bouncer/http@main"
        "github.com/hslatman/caddy-crowdsec-bouncer/layer4@main"
        "github.com/caddy-dns/cloudflare"
      ];
    };

    email = "stefanbondzulic@pm.me";

    virtualHosts."jf-en.bg.droiden.xyz".extraConfig = ''
      reverse_proxy 192.168.0.111:8096
      tls {
        dns cloudflare
      }
    '';
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
