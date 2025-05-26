{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
      fastlauncher-niri-windows-package = pkgs.callPackage ./package.nix {};
    in {
      packages = rec {
        fastlauncher-niri-windows = fastlauncher-package;
        default = fastlauncher-niri-windows;
      };

      apps = rec {
        fastlauncher-niri-windows = flake-utils.lib.mkApp {
          drv = self.packages.${system}.fastlauncher-niri-windows;
        };
        default = fastlauncher-niri-windows;
      };

      devShells.default = pkgs.mkShell {
        packages = (with pkgs; [
          go
        ]);
      };
    });
}
