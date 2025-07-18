{pkgs}: {
  channel = "stable-24.05";
  packages = [
    pkgs.jdk17
    pkgs.unzip
    pkgs.flutter
    pkgs.gcc
    pkgs.jdk17
    pkgs.unzip
    pkgs.rustc
    pkgs.cargo
    pkgs.pkg-config
    pkgs.protobuf
    pkgs.nano
    pkgs.gh
    pkgs.htop
    pkgs.cargo-expand
    pkgs.rustup
  ];
  idx.extensions = [
    
  ];
  idx.previews = {
    previews = {
      web = {
        command = [
          "flutter"
          "run"
          "--machine"
          "-d"
          "web-server"
          "--web-hostname"
          "0.0.0.0"
          "--web-port"
          "$PORT"
        ];
        manager = "flutter";
      };
      android = {
        command = [
          "flutter"
          "run"
          "--machine"
          "-d"
          "android"
          "-d"
          "localhost:5555"
        ];
        manager = "flutter";
      };
    };
  };
}