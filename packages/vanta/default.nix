{ lib, stdenvNoCC, fetchurl, p7zip, ... }:
let
  # version = "2.5.3";
  version = "2.6.1";
  workDir = "vanta-amd64";
in
stdenvNoCC.mkDerivation {
  pname = "vanta-agent";
  version = version;
  description = "Vanta Agent";
  meta = with lib; {
    homepage = "https://www.vanta.com";
  };

  # dontBuild = true;
  # dontConfigure = true;

  nativeBuildInputs = [ p7zip ];

  src = fetchurl {
    url = "https://vanta-agent-repo.s3.amazonaws.com/targets/versions/${version}/vanta-amd64.deb";
    sha256 = "sha256-zofGSN+dTXkvBb7cpywWImTfHGTuj8r0qbveJoByUSU=";
  };

  unpackCmd = ''
    mkdir -p ${workDir}
    7z x $curSrc -o${workDir}
    tar -xzf ${workDir}/data.tar.gz -C ${workDir}
  '';

  sourceRoot = "./${workDir}";

  installPhase = ''
    runHook preInstall

    # systemd
    install -Dm644 usr/lib/systemd/system/vanta.service $out/etc/systemd/system/vanta.service

    # systemd override for regular restart because of Agent instability
    echo '# Vanta agent regularly hang, this forces to regularly restart it
    [Service]
    Restart=always
    RuntimeMaxSec=12h
    ' > vanta.conf
    install -Dm644 vanta.conf $out/etc/systemd/system/vanta.service.d/vanta.conf

    # vanta
    for i in var/vanta/* ; do
      install -Dm755 $i $out/$i
    done

    runHook postInstall
  '';
}
