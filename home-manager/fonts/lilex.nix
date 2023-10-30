{ 
  python3Packages
, stdenv
, fetchFromGitHub
, nerd-font-patcher
, writeText
, writeShellScriptBin
, python3
, callPackage
, fetchVenv ? callPackage (import ./fetchVenv.nix) {}
, fontforge
} : 

{ features ? [] }:

stdenv.mkDerivation rec {
  pname = "lilex-nerd";
  version = "2.200";

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
    hash = "sha256-mrcF50FHmU+o0bG/C9PUC1FxfSwQoJHRc9Yz/g6ltE0=";
  });

  srcs = [ (fetchFromGitHub {
    owner = "mishamyrt";
    repo = "Lilex";
    rev = "a2b41f31d581c41116f3103b99519742ae6bcc05";
    sha256 = "qaylALYPzHeAn46KhSe5QAVPgCJdN2bbduigJR7IeXU=";
  }) env ];

  setSourceRoot = "sourceRoot=source";

  buildPhase = ''
    source ../venv/bin/activate
    python ./scripts/lilex.py --features '${builtins.concatStringsSep "," features}' build
    for f in build/ttf/*; do
      echo patching $f ...
      bash -c ${fontforge}/bin/fontforge -script ${nerd-font-patcher}/bin/nerd-font-patcher\
        -c --careful --has-no-italic "$f"
    done
    ls -l
    ls build/ttf/ -l
  '';

  installPhase = ''
    install -m 444 -Dt $out/share/fonts/truetype/Lilex build/ttf/*.ttf
  '';

  buildInputs = with python3Packages; [
    fontmake
  ];
}
