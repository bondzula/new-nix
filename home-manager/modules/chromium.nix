{
  programs.chromium = {
    enable = true;
    extensions = [
      # uBlock Origin
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
      # Vue Dev Tools
      { id = "nhdogjmejiglipccpnnnanhbledajbpd"; }
      # Bitwarden
      { id = "nngceckbapebfimnlniiiahkandclblb"; }
      # Readwise
      { id = "jjhefcfhmnkfeepcpnilbbkaadhngkbi"; }
      # Dark Reader
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; }
    ];
  };
}
