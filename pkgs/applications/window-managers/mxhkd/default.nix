{ stdenv, fetchFromGitHub, rustPlatform, python3, xorg,
  pkgconfig, ronn }:

rustPlatform.buildRustPackage rec {
  name = "mxhkd-${version}";
  version = "0.0.3";

  src = fetchFromGitHub {
    owner = "carlosdagos";
    repo = "mxhkd";
    rev = "v${version}";
    sha256 = "19ynhsv5rmzjpd2gfp9wd6g4gh67k390alkha27pd50sv64lg0rj";
  };

  cargoSha256 = "1241gpdm4ra7arz5rgvwqf21v02jkybh16cg592zghndwsifmg8i";

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [
    ronn
    python3
    xorg.libxcb
    xorg.libX11
    xorg.xmodmap
  ];

  preFixup = ''
    mkdir -p "$out/man/man1"
    cp doc/mxhkd.1 "$out/man/man1/"
  '';

  meta = with stdenv.lib; {
    description = "Modal X hotkey daemon";
    homepage = https://github.com/carlosdagos/mxhkd;
    license = with licenses; [ bsd2 ];
    maintainers = [ maintainers.carlosdagos ];
    platforms = platforms.linux;
  };
}
