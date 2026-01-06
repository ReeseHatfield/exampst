{ pkgs, lib, ... }:


pkgs.stdenv.mkDerivation rec {
  pname = "typst-utils";
  version = "1.0.0";

  src = ./.;
  # Copy fonts to the Nix store
  installPhase = ''
    mkdir -p $out/share/typst/packages/local/typst-utils
    cp -r $src/* $out/share/typst/packages/local/typst-utils/
  '';
}

