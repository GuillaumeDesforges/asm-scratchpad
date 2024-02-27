{ nixpkgs ? builtins.getFlake "nixpkgs"
, pkgs ? nixpkgs.legacyPackages.${builtins.currentSystem}
}:

pkgs.mkShell {
  buildInputs = [
    pkgs.yasm
    pkgs.bintools
    pkgs.ddd
    pkgs.gdb
    pkgs.gdb
  ];
}
