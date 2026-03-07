{
  description = "Personal Blog Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
            (writeShellScriptBin "serve" "hugo server -D --disableFastRender")
            hugo 
            go 
            git
            nodejs
          ];

          shellHook = ''
            echo "=========================================="
            echo "🌐   Personal Blog Environment Active   🌐"
            echo "=========================================="
            echo "Hugo version: $(hugo version | awk '{print $2}')"
            echo "Go version:   $(go version | awk '{print $3}')"
            echo "Node version:   $(node -V | awk '{print $4}')"
            
            echo ""
            echo ""
            echo ""

            echo "Run 'serve' to start the local dev server."

            echo ""
            echo ""
            echo ""
          '';
        };
      }
    );
}
