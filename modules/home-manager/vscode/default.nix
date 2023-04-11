{ pkgs, ... }: {  
    home.packages = with pkgs; [
        vscode
    ];
    home.sessionVariables = {
        EDITOR = "code";
    };
}