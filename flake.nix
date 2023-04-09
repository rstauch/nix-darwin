{
  description = "my minimal flake";
  inputs = {
    # Where we get most of our software. Giant mono repo with recipes
    # called derivations that say how to build software.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; # nixos-22.11
  
    # Manages configs links things into your home directory
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Controls system level software and settings including fonts
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs: {
    darwinConfigurations.Roberts-MacBook-Air =
      inputs.darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = import inputs.nixpkgs { system = "aarch64-darwin"; config.allowUnfree = true; };
        modules = [
          ({ pkgs, ... }: {
	    
            # here go the darwin preferences and config items
            programs.zsh.enable = true;
            environment.shells = [ pkgs.bash pkgs.zsh ];
            environment.loginShell = pkgs.zsh;
            environment.systemPackages = [ pkgs.coreutils pkgs.vscode pkgs.jq ] ;
            nix.extraOptions = ''
              experimental-features = nix-command flakes
            '';
            system.keyboard.enableKeyMapping = true;
            system.keyboard.remapCapsLockToEscape = true;
           
	    # fonts.fontDir.enable = true; # DANGER
            # fonts.fonts =
            #  [ (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; }) ];
           
	    services.nix-daemon.enable = true;
            # Dock
            system.defaults.dock.autohide = false;
            
            # Finder
            system.defaults.finder.AppleShowAllExtensions = true;
            system.defaults.finder._FXShowPosixPathInTitle = true;
            system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
            
            # keyboard
            system.defaults.NSGlobalDomain.InitialKeyRepeat = 14;
            system.defaults.NSGlobalDomain.KeyRepeat = 1;

            # Mouse
	          system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;

            # Other
            
            
            system.stateVersion = 4;
          })
          inputs.home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.rstauch.imports = [
                ({ pkgs, ... }: {
                  home.stateVersion = "22.11";

                  home.packages = [ pkgs.ripgrep pkgs.fd pkgs.curl pkgs.less ];
                  home.sessionVariables = {
                    PAGER = "less";
                    CLICLOLOR = 1;
		                EDITOR = "code";
                  };

                  programs.bat.enable = true;
                  programs.bat.config.theme = "TwoDark";
                  # programs.fzf.enable = true;
                  # programs.fzf.enableZshIntegration = true;
                  # programs.exa.enable = true;
                  programs.git.enable = true;
                  # programs.zsh.enable = true;
                  # programs.zsh.enableCompletion = true;
                  # programs.zsh.enableAutosuggestions = true;
                  # programs.zsh.enableSyntaxHighlighting = true;
                  # programs.zsh.shellAliases = { ls = "ls --color=auto -F"; };
                })
              ];
            };
          }
        ];
      };
  };
}
