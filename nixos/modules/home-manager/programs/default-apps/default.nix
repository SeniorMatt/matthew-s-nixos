{ pkgs, lib, config, ... }:
{
  options.defaultApps = with lib; {
    imageViewerPackage = mkOption {
      type = types.package;
      default = pkgs.eog;
    };
    imageViewer = mkOption {
      type = types.str;
      default = "org.gnome.eog.desktop";
    };

    documentViewerPackage = mkOption {
      type = types.package;
      default = pkgs.papers;
    };
    documentViewer = mkOption {
      type = types.str;
      default = "org.gnome.Papers.desktop";
    };

    mediaPlayerPackage = mkOption {
      type = types.package;
      default = pkgs.mpv;
    };
    mediaPlayer = mkOption {
      type = types.str;
      default = "mpv.desktop";
    };
  };

  config = with config.defaultApps; {
    home.packages = with pkgs; [
      imageViewerPackage
      documentViewerPackage
      mediaPlayerPackage
    ];

    xdg.mimeApps = with config.defaultApps; {
      enable = true;
      defaultApplications = {
        "image/png" = "${imageViewer}";
        "image/jpeg" = "${imageViewer}";
        "video/mp4" = "${mediaPlayer}";
        "audio/mp3" = "${mediaPlayer}";
        "audio/ogg" = "${mediaPlayer}";
        "audio/wav" = "${mediaPlayer}";
        "application/pdf" = "${documentViewer}";
      };
    };
  };
}
