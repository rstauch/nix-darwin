{pkgs, ...}: let
in {
  programs.zsh = {
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
}
