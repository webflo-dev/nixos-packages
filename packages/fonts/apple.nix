{ lib, stdenvNoCC, fetchurl, p7zip, ... }:

let
  mkFontDerivation = ({ name, url, sha256 }:
    stdenvNoCC.mkDerivation {
      pname = "${name}-font";
      version = "1.0";

      src = fetchurl {
        url = url;
        sha256 = sha256;
      };

      nativeBuildInputs = [ p7zip ];

      unpackCmd = ''
        7z x $curSrc
        find . -name "*.pkg" -print -exec 7z x {} \;
        find . -name "Payload~" -print -exec 7z x {} \;
      '';

      sourceRoot = "./Library/Fonts";

      dontBuild = true;

      installPhase = ''
        find . -name '*.ttf' -exec install -m444 -Dt $out/share/fonts/truetype {} \;
        find . -name '*.otf' -exec install -m444 -Dt $out/share/fonts/opentype {} \;
      '';

      meta = with lib; {
        homepage = "https://developer.apple.com/fonts/";
        description = "Apple fonts";
        # license = licenses.unfree;
        maintainers = [ maintainers.pinpox ];
      };
    });
in
{
  sf-pro = mkFontDerivation {
    name = "sf-pro";
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
    sha256 = "sha256-nkuHge3/Vy8lwYx9z+pvsQZfzrNIP4K0OutpPl4yXn0=";
  };
  sf-mono = mkFontDerivation {
    name = "sf-mono";
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg";
    sha256 = "sha256-pqkYgJZttKKHqTYobBUjud0fW79dS5tdzYJ23we9TW4=";
  };
  new-york = mkFontDerivation {
    name = "new-york";
    url = "https://devimages-cdn.apple.com/design/resources/download/NY.dmg";
    sha256 = "sha256-XOiWc4c7Yah+mM7axk8g1gY12vXamQF78Keqd3/0/cE=";
  };

}
