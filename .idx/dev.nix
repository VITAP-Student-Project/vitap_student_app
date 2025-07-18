{pkgs}: {
  channel = "unstable";
  packages = [
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
    pkgs.libsecret
    pkgs.flutter
    pkgs.cmake
    pkgs.ninja
    pkgs.pkg-config
    pkgs.libsecret.dev
    pkgs.dbus.dev
    pkgs.gtk3
    pkgs.libclang
    pkgs.clang
  ];
  idx.extensions = [

  
 "Dart-Code.flutter"];
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