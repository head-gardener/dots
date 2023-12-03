{ python3Packages, stdenv, fetchFromGitHub, python3, callPackage
, fetchVenv ? callPackage (import ./fetchVenv.nix) { }, features ? [ ] }:

stdenv.mkDerivation rec {
  pname = "lilex";
  version = "2.300";

  # this fucking sucks
  env = (fetchVenv {
    name = "lilexenv";
    req = builtins.readFile ./pip.lock;
    python = python3;
    pythonPackages = python3Packages;
    hash = "sha256-Hcpsu7+yiBbYoSjKzX3Hv3xrW8dqh7GAoX5UNMhfEU8=";
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
