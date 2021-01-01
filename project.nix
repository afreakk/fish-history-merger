{ mkDerivation, base, containers, stdenv, text, text-builder }:
mkDerivation {
  pname = "fish-history-merger";
  version = "0.1.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base text text-builder ];
  executableHaskellDepends = [ base containers text ];
  testHaskellDepends = [ base ];
  license = stdenv.lib.licenses.bsd3;
}
