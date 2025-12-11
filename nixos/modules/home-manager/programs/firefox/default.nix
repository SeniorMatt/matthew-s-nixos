{
  programs.firefox = {
    enable = true;

    # preferences = {
    #   # disable libadwaita theming for Firefox
    #   "widget.gtk.libadwaita-colors.enabled" = false;
    # };

    profiles.default.settings = {
      "browser.urlbar.suggest.calculator" = true;
      "browser.newtabpage.activity-stream.trendingSearch.defaultSearchEngine" = "DuckDuckGo";
    };

    policies = {
      SearchEngines = {
        Default = "DuckDuckGo";
        Remove = ["Google"];
        Add = [
          {
            Name = "YouTube";
            Alias = "yt";
            URLTemplate = "https://www.youtube.com/results?search_query={searchTerms}";
            IconURL = "https://www.youtube.com/favicon.ico";
          }
          {
            Name = "NixOS packages";
            Alias = "nx";
            URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
            IconURL = "https://nixos.org/favicon.ico";
          }
        ];
      };
    };
  };
}
