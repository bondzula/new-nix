# User configuration for bat
{
  programs.bat = {
    enable = true;
    config = {
      theme = "Catppuccin-mocha";
      style = "plain";
    };
  };

  xdg.configFile."bat/themes" = {
    recursive = true;
    source = ./themes;
    onChange = "bat cache --build";
  };

  programs.zsh = {
    shellAliases = { cat = "bat"; };
    envExtra = ''
      export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    '';
  };
}
