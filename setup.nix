let
    getpkgs = import <nixpkgs>;
    pkgs = getpkgs {};
in
    pkgs.mkShell {
        buildInputs = [
            pkgs.git
            pkgs.hugo
            pkgs.fish
        ];
        shellHook = ''
            hugo version
            exec fish
        '';
    }  