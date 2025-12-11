{ stdenvNoCC, pkgs, }:
stdenvNoCC.mkDerivation {
  pname = "Effect geometry change";
  version = "1.0";
  src = pkgs.fetchzip {
    url = "https://github.com/peterfajdiga/kwin4_effect_geometry_change/releases/download/v1.5/kwin4_effect_geometry_change_1_5.tar.gz";
    sha256 = "sha256-1xjG6tIaUj97T2yHq+W7MLcODS0BN/yOzKgpql1/q1k=";
    stripRoot = false;
  };
  installPhase = ''
    mkdir -p $out/share/kwin/effects
    cp -r "$src"/* "$out/share/kwin/effects/"
  '';
}
