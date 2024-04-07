{ config, pkgs, lib, ... }:

with lib;

let cfg = config.modules.nextcloud;
in {
  options.modules.nextcloud = { enable = mkEnableOption "Deploy NextCloud"; };

  config = mkIf cfg.enable {
    environment.etc."nextcloud-admin-pass".text = "Tasimirka1!";

    services = {
      nextcloud = {
        enable = true;
        hostName = "localhost";

        # Need to manually increment with every major upgrade.
        package = pkgs.nextcloud28;

        # Let NixOS install and configure the database automatically.
        database.createLocally = true;

        # Let NixOS install and configure Redis caching automatically.
        configureRedis = true;

        # Data storage
        home = "/tank/nextcloud";

        # Increase the maximum file upload size to avoid problems uploading videos.
        maxUploadSize = "2G";
        https = true;

        autoUpdateApps.enable = true;
        extraAppsEnable = true;
        extraApps = with config.services.nextcloud.package.packages.apps; {
          # List of apps we want to install and are already packaged in
          # https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/nextcloud/packages/nextcloud-apps.json
          inherit calendar;
        };

        settings = { trusted_domains = [ "nextcloud.bg.bondzulic.com" ]; };

        config = {
          dbtype = "pgsql";
          adminuser = "admin";
          adminpassFile = "/etc/nextcloud-admin-pass";
        };
      };

      nginx.virtualHosts = {
        "localhost" = {
          forceSSL = false;
          enableACME = false;
          listen = [{
            addr = "127.0.0.1";
            port = 2323;
          }];
        };
      };

      caddy.virtualHosts."nextcloud.bg.bondzulic.com".extraConfig = ''
        reverse_proxy 127.0.0.1:2323
      '';
    };
  };
}
