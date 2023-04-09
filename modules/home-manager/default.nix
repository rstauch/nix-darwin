{ pkgs, ... }: {  
    home.stateVersion = "22.11";

    home.packages = with pkgs; [
        ripgrep
        fd
        curl
        less
        vscode
    ];
    home.sessionVariables = {
        PAGER = "less";
        CLICLOLOR = 1;
        EDITOR = "code";
    };

    programs.bat.enable = true;
    programs.bat.config.theme = "TwoDark";
    programs.fzf.enable = true;
    programs.fzf.enableZshIntegration = true;
    programs.exa.enable = true;
    programs.git.enable = true;
    programs.zsh.enable = true;
    programs.zsh.enableCompletion = true;
    programs.zsh.enableAutosuggestions = true;
    programs.zsh.enableSyntaxHighlighting = true;
    programs.zsh.shellAliases = {
        ls = "ls --color=auto -F";
        nixswitch = "darwin-rebuild switch --flake ~/projects/int/nix/.#";
        nixup = "pushd ~/projects/int/nix; nix flake update; nixswitch; popd";
    };

}