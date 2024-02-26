{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Stefan Bondzulic";
    userEmail = "stefanbondzulic@gmail.com";

    aliases = {
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --branches";
    };
    extraConfig = {
      init.defaultBranch = "main";
      featch.prune = true;
      pull.rebase = true;
      merge.conflictstyle = "diff3";
      diff.external = "difft";
    };
  };

  # Enable GitHub CLI as well
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };

  home.packages = with pkgs; [
    difftastic
  ];
}
