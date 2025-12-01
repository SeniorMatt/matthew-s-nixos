{
  stdenvNoCC,
  lib,
}:
stdenvNoCC.mkDerivation {
  pname = "m6x11";
  version = "0.1";
  src = ../fonts;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/
    cp -r $src/*.{ttf,otf} $out/share/fonts/truetype/
  '';

  meta = with lib; {
    description = "M6 X11";
    homepage = "https://www.yourfontwebsite.com/";
    platforms = platforms.all;
  };
}
