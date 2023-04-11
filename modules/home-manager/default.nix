{pkgs, ...}: let
in {
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    ripgrep
    fd
    curl
    less
  ];
  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
  };

  # TODO: vollständige config einführen
  programs = {
    bat = {
      enable = true;
      config.theme = "TwoDark";
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    exa.enable = true;

    git = {
      enable = true;
    };
  };
}
