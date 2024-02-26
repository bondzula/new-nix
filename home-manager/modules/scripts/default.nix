{
  # Script to manage Tmux sessions
  xdg.configFile."bin/tmux-sessionizer" = {
    source = ./tmux-sessionizer;
    executable = true;
  };

  # Script to manage Tmux window names (icons)
  xdg.configFile."bin/tmux-icon-name" = {
    source = ./tmux-icon-name;
    executable = true;
  };

  # Script to manage Tmux window names (icons)
  xdg.configFile."bin/zellij-zoxide" = {
    source = ./zellij-zoxide;
    executable = true;
  };

  # Script to manage Tmux window names (icons)
  xdg.configFile."bin/zs" = {
    source = ./zellij-session;
    executable = true;
  };

  # Add ~/config/bin to PATH
  programs.zsh.initExtra = ''
    path+=('/home/bondzula/.config/bin')
  '';
}
