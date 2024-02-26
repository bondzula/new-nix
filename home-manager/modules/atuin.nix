{
  programs.atuin = {
    enable = true;
    flags = [
      "--disable-up-arrow"
    ];
    settings = {
      style = "compact";
      inline_height = 20;
    };
    enableZshIntegration = true;
  };
}
