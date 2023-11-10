{ python3Packages, stdenv, fetchFromGitHub, nerd-font-patcher, writeText
, writeShellScriptBin, python3, callPackage
, fetchVenv ? callPackage (import ./fetchVenv.nix) { }, fontforge }:

{ features ? [ ] }:

stdenv.mkDerivation rec {
  pname = "lilex";
  version = "2.300";

  env = (fetchVenv {
    name = "lilexenv";
    req = ''
      fontmake==3.7.1
      cu2qu==1.6.7
      gftools==0.9.35
      glyphsLib==6.4.1
      arrrgs==2.0.0
      # ruff==0.1.2
      # pylint==3.0.2
      colored==2.2.3
      pylance==0.8.7
      fontbakery==0.10.2
    '';
    python = python3;
    pythonPackages = python3Packages;
    hash = "sha256-cx5Bu8jtQMbtSLxbUgHj5rzTMsxpyBJ8hhIgH27ucuU=";
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

  buildInputs = with python3Packages; [ fontmake ];
}
