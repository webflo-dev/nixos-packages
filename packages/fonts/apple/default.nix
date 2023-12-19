{ lib
, stdenvNoCC
, fetchurl
, p7zip
}:
let
  sources = {
    sf-pro = {
      url =
        "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
      sha256 = "sha256-P69DHx/V0NoDcI6jrZdlhbpjrdHo8DEGT+2yg5jYw/M=";
    };
    sf-mono = {
      url =
        "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg";
      sha256 = "sha256-8niJPk3hGfK1USIs9eoxZ6GlM4aZ7ZObmQj2Zomj+Go=";
    };
    new-york = {
      url =
        "https://devimages-cdn.apple.com/design/resources/download/NY.dmg";
      sha256 = "sha256-P69DHx/V0NoDcI6jrZdlhbpjrdHo8DEGT+2yg5jYw/O=";
    };
    sf-symbols = {
      url = "https://devimages-cdn.apple.com/design/resources/download/SF-Symbols-5.dmg";
    };
  };

  derivation = name: value: stdenvNoCC.mkDerivation {
    pname = "${name}-font";
    version = "1.0";
    meta = with lib; {
      homepage = "https://developer.apple.com/fonts";
      description = "Apple fonts";
      platforms = platforms.all;
    };

    dontBuild = true;
    dontUnpack = true;
    dontConfigure = true;

    src = fetchurl {
      url = value.url;
      sha256 = value.sha256;
    };

    nativeBuildInputs = [ p7zip ];

    unpackCmd = ''
      7z x $curSrc
      find . -name "*.pkg" -print -exec 7z x {} \;
      find . -name "Payload~" -print -exec 7z x {} \;
    '';

    sourceRoot = "./Library/Fonts";

    installPhase = ''
      find . -name '*.ttf' -exec install -m444 -Dt $out/share/fonts/truetype {} \;
      find . -name '*.otf' -exec install -m444 -Dt $out/share/fonts/opentype {} \;
    '';

  };
in
lib.mapAttrs derivation sources


