{ mkDerivation, base, containers, deepseq, stdenv }:
mkDerivation {
  pname = "fish-history-merger";
  version = "0.1.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base deepseq ];
  executableHaskellDepends = [ base containers ];
  testHaskellDepends = [ base ];
  license = stdenv.lib.licenses.bsd3;
}
