{ mkDerivation, base, containers, stdenv, lib, pkgs}:
mkDerivation {
  pname = "fish-history-merger";
  version = "0.1.0";
  src = pkgs.nix-gitignore.gitignoreSource [".git/" "*.nix"] ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base ];
  executableHaskellDepends = [ base containers ];
  testHaskellDepends = [ base ];
  license = lib.licenses.bsd3;
}
