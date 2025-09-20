{
  programs.firefox = {
    enable = true;

    profiles.default.settings = {
      "browser.urlbar.suggest.calculator" = true;
      "browser.newtabpage.activity-stream.trendingSearch.defaultSearchEngine" = "DuckDuckGo";
    };

    policies = {
      SearchEngines = {
        Default = "DuckDuckGo";
        PreventInstalls = false; # allow user to add more if they want
        Remove = ["Bing" "Google" "DuckDuckGo"];

        Add = [
          {
            Name = "Bastards";
            Alias = "g";
            URLTemplate = "https://www.google.com/search?q={searchTerms}";
            IconURL = "https://www.google.com/favicon.ico";
          }

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
