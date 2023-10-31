{ pkgs }:

rec {
  dmenu = pkgs.callPackage ../dmenu { };

  patcher = pkgs.callPackage ../fonts/nerdPatched.nix { };

  lilex = let
    pkg = pkgs.callPackage ../fonts/lilex.nix { };
    font = pkg {
      features = [ "cv01" "cv03" "cv06" "cv09" "cv10" "cv11" "ss01" "ss03" ];
    };
  in patcher { inherit font; };

  main-menu = pkgs.callPackage ../menu { };
}
