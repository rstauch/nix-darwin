# https://rycee.gitlab.io/home-manager/options.html
{
  config,
  pkgs,
  ...
}: let
  darwinSockPath = "/Users/rstauch/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
  sockPath = "/Users/rstauch/.1password/agent.sock";

  java = import ./java17.nix {
    inherit pkgs;
  };

  dev = import ./dev.nix {
    inherit pkgs;
  };

  k8s = import ./k8s.nix {
    inherit pkgs;
  };

  broot = import ./broot/broot.nix;

  imports = [java dev k8s broot];
in {
  inherit imports;
  home.username = "rstauch";
  home.homeDirectory = pkgs.lib.mkForce "/Users/rstauch";

  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    bottom
    du-dust
    openssh
    openssl
    fd
    tldr

    ripgrep

    curl
    less

    # see https://determinate.systems/posts/nix-home-env
    direnv
    # see https://determinate.systems/posts/nix-direnv
    nix-direnv

    #jetbrains.idea-ultimate
  ];
  home.sessionVariables = {
    GIT_PAGER = "";
    PAGER = "${pkgs.less}/bin/less -RF --mouse --wheel-lines=3";
    CLICLOLOR = 1;
    SSH_AUTH_SOCK = sockPath;
  };

  programs = {
    git = {
      enable = true;
      userName = pkgs.lib.mkForce "Stauch, R. (Robert)";
      userEmail = "robert.stauch@fluxdev.de";
      extraConfig = {
        core = {
          longpaths = true;
          autocrlf = "input";
          excludesfile = "/Users/rstauch/.gitignore_global";
        };
      };
    };

    ssh = {
      enable = true;
      extraConfig = ''
        IdentityAgent "${sockPath}"
      '';
    };
  };

  home.file.sock = {
    source = config.lib.file.mkOutOfStoreSymlink darwinSockPath;
    target = ".1password/agent.sock";
  };

  home.file."Library/Application Support/iTerm2/DynamicProfiles/iterm2_profile.json".source = ./iterm2_profiles.json;

  home.file.".config/broot/verbs.hjson".source = ./broot/verbs.hjson;
  home.file.".gitignore_global".source = ./.gitignore_global;
}
