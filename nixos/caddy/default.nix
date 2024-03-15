{ config, pkgs, lib, ... }:

with lib;

let

  cfg = config.modules.caddy;

  caddyMetricsPort = 2019;
in {

  options = {
    modules = {
      caddy = { enable = mkEnableOption "Deploy reverse proxy Caddy"; };
    };
  };

  config = mkIf cfg.enable {

    # Allow network access when building
    # https://mdleom.com/blog/2021/12/27/caddy-plugins-nixos/#xcaddy
    nix.settings.sandbox = false;

    networking.firewall.allowedTCPPorts = [
      80 # Caddy
      443 # Caddy
      caddyMetricsPort
    ];

    services.caddy = {
      enable = true;
      package = pkgs.callPackage ./custom-caddy.nix {
        plugins = [ "github.com/caddy-dns/cloudflare" ];
      };
    };
  };
}
