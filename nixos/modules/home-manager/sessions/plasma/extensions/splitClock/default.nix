{ stdenvNoCC, pkgs, }:
stdenvNoCC.mkDerivation {
  pname = "Split clock for vertical panels widget";
  version = "1.0";
  src = pkgs.fetchFromGitHub {
    owner = "bainonline";
    repo = "split-clock";
    rev = "main";
    sha256 = "sha256-PTPVK6zrmEbFaaAwkPUPD9MPgDxJm2PMOkDrSKMAhuo=";
    stripRoot = false;
  };
  installPhase = ''
    mkdir -p $out/share/plasma/plasmoids/split-clock
    cp -r "$src"/split-clock-main/* "$out/share/plasma/plasmoids/split-clock/"
  '';
}
