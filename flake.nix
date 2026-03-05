{
  description = "Personal Blog Environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            hugo
            go
            git
            nodejs
          ];

          shellHook = ''
            echo "Hugo Version: $(hugo version)"
            echo "Node Version: $(node -v)"
          '';
        };
      }
    );
}
