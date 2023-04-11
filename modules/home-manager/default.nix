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

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      shellAliases = {
        ls = "ls --color=auto -F";

        nixswitch = "darwin-rebuild switch --flake ~/projects/int/nix/.#";
        nixup = "pushd ~/projects/int/nix; nix flake update; nixswitch; popd";
      };
    };
  };
}
