{ pkgs, ... }:
{
  luciole = pkgs.stdenvNoCC.mkDerivation {
    pname = "luciole-fonts";
    version = "1.0.0";
    meta = with pkgs.lib; {
      homepage = "https://www.luciole-vision.com";
      description = "Le caractère typographique Luciole a été conçu spécifiquement pour les personnes malvoyantes. Ce projet est le résultat de plus de deux années de collaboration entre le Centre Technique Régional pour la Déficience Visuelle et le studio typographies.fr. Le projet a bénéficié d'une bourse de la Fondation suisse Ceres et de l'appui du laboratoire DIPHE de l'Université Lumière Lyon 2.";
      licence = licences.cc-by-40;
      platforms = platforms.all;
    };

    dontBuild = true;
    dontConfigure = true;

    src = pkgs.fetchzip {
      url = "https://www.luciole-vision.com/Fichiers/Luciole_webfonts.zip";
      stripRoot = false;
      sha256 = "sha256-67yd5U8RmTX+zf9qnmrnZ4WITV674DJcYWovXaS402Y=";
    };

    installPhase = ''
      runHook preInstall

      pushd Luciole_webfonts
      install -Dm444 **/*.ttf -t $out/share/fonts/truetype
      popd

      runHook postInstall
    '';
  };
}
