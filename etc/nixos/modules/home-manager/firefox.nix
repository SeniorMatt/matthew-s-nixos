{
  programs.firefox = {
    enable = true;

    profiles.default.settings = {
      "browser.urlbar.suggest.calculator" = true;
      "browser.newtabpage.activity-stream.trendingSearch.defaultSearchEngine" = "DuckDuckGo";
    };
  };
}
