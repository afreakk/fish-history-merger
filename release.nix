{ pkgs ? import <nixpkgs> { } }:
{
  fish-history-merger = pkgs.haskellPackages.callPackage ./project.nix { };
}
