# User configuration for fzf
{ config, ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    # Default command for the ALT+C key binding
    # Only list directories which aren't ignored by VCS. The `.git` directory is always ignored.
    changeDirWidgetCommand =
      "command fd --hidden --type directory --exclude .git";
    # Default command to use when input is tty
    # Only list files which aren't ignored by VCS. Files under the `.git` directory are always ignored.
    defaultCommand = "command fd --hidden --type file --exclude .git";
    # Default command for the CTRL+T key binding
    fileWidgetCommand = "${config.programs.fzf.defaultCommand}";
    # Default settings
    defaultOptions = [
      "--color=spinner:#f5e0dc,hl:#f38ba8"
      "--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc"
      "--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
      "--min-height=100 --reverse"
      "--no-separator"
    ];
  };
}
