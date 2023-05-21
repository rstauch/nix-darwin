{pkgs, ...}: let
  vscodeSettings = import ./vscode_settings.nix {inherit pkgs;};
in {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    userSettings = vscodeSettings.getUserSettings;
    keybindings = import ./vscode_keybindings_mac.nix;
    extensions =
      with pkgs.vscode-extensions; [
        ms-azuretools.vscode-docker
        skellock.just
        jnoortheen.nix-ide
        foxundermoon.shell-format
        kamadorueda.alejandra
        timonwong.shellcheck
        mhutchie.git-graph
        alefragnani.project-manager

        # TODO: enable this
        # github.copilot
      ]
      # TODO: get this to work
      # ++ (with pkgs.nur.repos.slaier.vscode-extensions; [
      #  ms-vscode-remote.remote-containers
      # ])
      ;
  };

  home.packages = with pkgs; [
    fmt
    nixpkgs-fmt
    alejandra
    shfmt
  ];

  home.sessionVariables = {
    EDITOR = "code";
  };
}
