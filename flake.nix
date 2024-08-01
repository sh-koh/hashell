{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];
      perSystem = { pkgs, ... }: {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [ ghc haskell-language-server ];
        };
        packages.default = pkgs.stdenv.mkDerivation (finalAttrs: 
        let
          pname = "hashell";
        in {
          inherit pname;
          version = "git";
          src = ./.;
          buildInputs = with pkgs; [
            ghc
          ];
          buildPhase = ''
            mkdir -p $out/bin
            ${pkgs.ghc}/bin/ghc src/Main.hs -o ${pname}
            cp ${pname} $out/bin/${pname}
          '';
        });
      };
    };
}
