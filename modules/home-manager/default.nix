{pkgs, ...}: let
in {
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    ripgrep
    fd
    curl
    less
    exa

    # see https://determinate.systems/posts/nix-home-env
    direnv
    # see https://determinate.systems/posts/nix-direnv
    nix-direnv
  ];
  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
  };

  # TODO: vollständige config einführen
  programs = {
    git = {
      enable = true;
    };
  };
}
