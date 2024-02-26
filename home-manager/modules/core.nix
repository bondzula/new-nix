{ pkgs, ... }:

# CLI Packages used on every system
{
  imports = [
    ./bat
    ./btop.nix
    ./direnv.nix
    ./eza.nix
    ./fd.nix
    ./fzf.nix
    ./git.nix
    ./nvim.nix
    ./ripgrep.nix
    ./tmux.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    curl
    du-dust # Modern Unix `du`
    dua # Modern Unix `du`
    duf # Modern Unix `df`
    fd # Modern Unix `find`
    gping # Modern Unix `ping`
    httpie # Modern curl
    hyperfine # Terminal benchmarking
    magic-wormhole
    moar # Modern Unix `less`
    neofetch # Terminal system info
    nmap
    procs # Modern Unix `ps`
    tldr # Modern Unix `man`
    tokei # Modern Unix `wc` for code
    trash-cli
    unzip
    wget
    yazi
  ];
}
