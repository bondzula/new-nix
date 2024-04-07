{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.caddy;
  # cloudflareApi = [ (builtins.readFile /home/bondzula/cloudflare_api) ];
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

    networking.firewall.allowedTCPPorts = [ 80 443 ];

    services.caddy = {
      enable = true;
      package = pkgs.callPackage ./custom-caddy.nix {
        plugins = [
          "github.com/mholt/caddy-l4"
          "github.com/caddyserver/caddy/v2/modules/standard"
          "github.com/hslatman/caddy-crowdsec-bouncer/http@main"
          "github.com/hslatman/caddy-crowdsec-bouncer/layer4@main"
          "github.com/caddy-dns/cloudflare"
        ];
      };

      email = "stefanbondzulic@pm.me";
      globalConfig = ''
        acme_dns cloudflare {env.CF_API_TOKEN}
      '';
    };

    systemd.services.caddy = {
      serviceConfig = {
        # Required to use ports < 1024
        AmbientCapabilities = "cap_net_bind_service";
        CapabilityBoundingSet = "cap_net_bind_service";
        EnvironmentFile = /home/bondzula/cloudflare_api;
        TimeoutStartSec = "5m";
      };
    };
  };
}
