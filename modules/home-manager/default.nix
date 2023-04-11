{pkgs, ...}: let
  PROJECT_ROOT = builtins.toString ./../../.;
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

        nixswitch = "darwin-rebuild switch --flake ${PROJECT_ROOT}/.#";

        # scheint nur aus vscode terminal in projekt verzeichnis zu funktionieren ?
        nixup = "pushd ${PROJECT_ROOT}; nix flake update; nixswitch; popd";
      };
    };
  };
}
