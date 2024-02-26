{ pkgs, ... }:

{
  home.packages = with pkgs; [ lf ];

  xdg.configFile."lf/lfrc".source = ./lfrc;
  xdg.configFile."lf/previewer.sh" = {
    executable = true;
    source = ./previewer.sh;
  };
}
