{ config, lib, ... }:

with lib;

let cfg = config.modules.media;
in {
  options.modules.media = { enable = mkEnableOption "Deploy Sonarr"; };

  config = mkIf cfg.enable {

    # media group to be used by each service
    users.groups.media = {
      gid = 1800;
      members = [ "bondzula" ];
    };

    services = {
      prowlarr = { enable = true; };

      sonarr = {
        enable = true;
        group = "media";
      };

      radarr = {
        enable = true;
        group = "media";
      };

      bazarr = {
        enable = true;
        group = "media";
      };

      lidarr = {
        enable = true;
        group = "media";
      };

      readarr = {
        enable = true;
        group = "media";
      };

      audiobookshelf = {
        enable = true;
        port = 8585;
        group = "media";
      };

      plex = {
        enable = true;
        group = "media";
      };

      tautulli = {
        enable = true;
        group = "media";
      };

      jellyfin = {
        enable = true;
        group = "media";
        # TODO: setup temp dir to be on the RAM
        # cacheDir = "/tmp";
      };

      caddy = {
        virtualHosts."prowlarr.bg.droiden.xyz".extraConfig = ''
          reverse_proxy 127.0.0.1:9696
        '';

        virtualHosts."sonarr.bg.droiden.xyz".extraConfig = ''
          reverse_proxy 127.0.0.1:8989
        '';

        virtualHosts."radarr.bg.droiden.xyz".extraConfig = ''
          reverse_proxy 127.0.0.1:7878
        '';

        virtualHosts."bazarr.bg.droiden.xyz".extraConfig = ''
          reverse_proxy 127.0.0.1:6767
        '';

        virtualHosts."lidarr.bg.droiden.xyz".extraConfig = ''
          reverse_proxy 127.0.0.1:8686
        '';

        virtualHosts."readarr.bg.droiden.xyz".extraConfig = ''
          reverse_proxy 127.0.0.1:8787
        '';

        virtualHosts."audiobookshelf.bg.droiden.xyz".extraConfig = ''
          reverse_proxy 127.0.0.1:8585
        '';

        virtualHosts."plex.bg.bondzulic.com".extraConfig = ''
          reverse_proxy 127.0.0.1:32400
        '';

        virtualHosts."tautulli.bg.droiden.xyz".extraConfig = ''
          reverse_proxy 127.0.0.1:8181
        '';

        virtualHosts."jellyfin.bg.bondzulic.com".extraConfig = ''
          reverse_proxy 127.0.0.1:8096
        '';
      };
    };
  };
}
