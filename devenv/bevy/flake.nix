{

  inputs = {
    naersk.url = "github:nmattia/naersk/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, naersk }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        naersk-lib = pkgs.callPackage naersk { };
      in {

        defaultPackage = naersk-lib.buildPackage ./.;

        defaultApp = utils.lib.mkApp { drv = self.defaultPackage."${system}"; };

        devShell = with pkgs;
          mkShell {
            buildInputs = [
              cargo
              rustc
              rustfmt
              pre-commit
              rustPackages.clippy
              pkg-config
              alsa-lib
              libudev-zero
              #NOTE Add more deps
              vulkan-loader
              xorg.libX11
              xorg.libxkbfile
              # x11
              xorg.libXrandr
              xorg.libXcursor
              xorg.libXi
            ];
            RUST_SRC_PATH = rustPlatform.rustLibSrc;
          };

      });

}
