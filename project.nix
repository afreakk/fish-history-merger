{ mkDerivation, base, containers, stdenv, lib }:
mkDerivation {
  pname = "fish-history-merger";
  version = "0.1.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base ];
  executableHaskellDepends = [ base containers ];
  testHaskellDepends = [ base ];
  license = lib.licenses.bsd3;
}
