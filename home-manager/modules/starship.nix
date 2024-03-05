# User configuration for starship
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      # Disable AWS module
      aws = { disabled = true; };

      # Enable nix_shell
      nix_shell = {
        symbol = "❄️";
        format = "via [$symbol $state](bold blue)";
      };

      # Disable the container indicator
      container = { disabled = true; };
    };
  };
}
