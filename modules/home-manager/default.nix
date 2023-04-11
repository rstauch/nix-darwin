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

    jq
    just
    openssl
    openssh
  ];
  home.sessionVariables = {
    GIT_PAGER = "";
    PAGER = "${pkgs.less}/bin/less -RF --mouse --wheel-lines=3";
    CLICLOLOR = 1;
  };

  programs = {
    git = {
      enable = true;
      userName = "Robert Stauch";
      userEmail = "robert.stauch@fluxdev.de";
    };
  };
}
