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

  imports = [java];
in {
  inherit imports;

  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    ripgrep
    du-dust
    fd
    bottom
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

    jetbrains.idea-ultimate
  ];
  home.sessionVariables = {
    GIT_PAGER = "";
    PAGER = "${pkgs.less}/bin/less -RF --mouse --wheel-lines=3";
    CLICLOLOR = 1;
    SSH_AUTH_SOCK = sockPath;
  };

  programs = {
    git = {
      # TODO: ggf. commit signing aktivieren ?
      enable = true;
      userName = "Robert Stauch";
      userEmail = "robert.stauch@fluxdev.de";
    };

    ssh = {
      enable = true;
      extraConfig = ''
        IdentityAgent "${sockPath}"
      '';
    };

    broot = {
      enable = true;

      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
  };

  home.file.sock = {
    source = config.lib.file.mkOutOfStoreSymlink darwinSockPath;
    target = ".1password/agent.sock";
  };

  home.file."Library/Application Support/iTerm2/DynamicProfiles/iterm2_profile.json".source = ./iterm2_profiles.json;
}
