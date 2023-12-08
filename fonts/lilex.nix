{ python3Packages, stdenv, fetchFromGitHub, python3, features ? [ ], ttfautohint}:

stdenv.mkDerivation {
  pname = "lilex";
  version = "2.300";

  srcs = [(fetchFromGitHub {
    owner = "mishamyrt";
    repo = "Lilex";
    rev = "0196c951c57d641beee3f038e7e41c223f5cb736";
    sha256 = "hkPVotB5Xs7TpFJTwcpKT3YS2rIKSGgeJ8iskrDO7g8=";
  })];

  outputHash = "sha256-n7DfIiypUe6ONm223aUhzWECbk3rV3PgA3VDkrwvzhc=";
  outputHashAlgo = "sha256";
  outputHashMode= "recursive";

  configurePhase = ''
    python -m venv venv
    . venv/bin/activate
    cp ${./requirements.txt} requirements.txt
    pip install --no-cache-dir -r requirements.txt
  '';

  buildPhase = ''
    python ./scripts/lilex.py --features '${
      builtins.concatStringsSep "," features
    }' build
  '';

  installPhase = ''
    install -m 444 -Dt $out/share/fonts/truetype/Lilex build/ttf/*.ttf
  '';

  buildInputs = with python3Packages; [ python3 fontmake ttfautohint cu2qu ];
}
