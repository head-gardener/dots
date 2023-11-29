{ python3Packages, stdenv, fetchFromGitHub, python3, callPackage
, fetchVenv ? callPackage (import ./fetchVenv.nix) { }, features ? [ ] }:

stdenv.mkDerivation rec {
  pname = "lilex";
  version = "2.300";

  env = (fetchVenv {
    name = "lilexenv";
    req = ''
      gftools==0.9.35
      arrrgs==2.0.0
      fontbakery==0.10.3
    '';
    python = python3;
    pythonPackages = python3Packages;
    hash = "sha256-7E/1291/GPSQwodKkealYeyg5cjJLSBuhUoj8ykMhVQ=";
    inputs = with python3Packages; [ cu2qu colored glyphslib ];
  });

  srcs = [
    (fetchFromGitHub {
      owner = "mishamyrt";
      repo = "Lilex";
      rev = "0196c951c57d641beee3f038e7e41c223f5cb736";
      sha256 = "hkPVotB5Xs7TpFJTwcpKT3YS2rIKSGgeJ8iskrDO7g8=";
    })
    env
  ];

  setSourceRoot = "sourceRoot=source";

  buildPhase = ''
    source ../venv/bin/activate
    python ./scripts/lilex.py --features '${
      builtins.concatStringsSep "," features
    }' build
  '';

  installPhase = ''
    install -m 444 -Dt $out/share/fonts/truetype/Lilex build/ttf/*.ttf
  '';

  buildInputs = with python3Packages; [ python3 fontmake ];
}
