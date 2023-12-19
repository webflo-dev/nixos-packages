{ lib
, stdenvNoCC
, fetchUrl
}:
stdenvNoCC.mkDerivation {
  pname = "luciole-fonts";
  version = "1.0.0";
  meta = with lib; {
    homepage = "https://www.luciole-vision.com";
    description = "Le caractère typographique Luciole a été conçu spécifiquement pour les personnes malvoyantes. Ce projet est le résultat de plus de deux années de collaboration entre le Centre Technique Régional pour la Déficience Visuelle et le studio typographies.fr. Le projet a bénéficié d'une bourse de la Fondation suisse Ceres et de l'appui du laboratoire DIPHE de l'Université Lumière Lyon 2.";
    licence = lib.licences.cc-by-40;
    platforms = platforms.all;
  };

  dontBuild = true;
  dontUnpack = true;
  dontConfigure = true;

  src = fetchzip {
    url = "https://www.luciole-vision.com/Fichiers/Luciole_webfonts.zip";
    stripRoot = false;
    sha256 = "";
  };

  installPhase = ''
    runHook preInstall

    pushd Luciole_webfonts
    install -Dm444 **/*.ttf -t $out/share/fonts/truetype
    popd

    runHook postInstall
  '';

}
