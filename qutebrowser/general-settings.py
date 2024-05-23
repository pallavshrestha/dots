config.set("colors.webpage.bg", "#93a1a1")
config.set("colors.webpage.preferred_color_scheme", "dark")
# config.set("colors.webpage.darkmode.enabled", True)
config.set("colors.webpage.darkmode.policy.images", "never")
config.set("url.default_page", "file:///home/pallav/.config/startpage/index.html")
config.set(
    "url.searchengines",
    {
        "DEFAULT": "https://search.brave.com/search?q={}",
        "duck": "https://duckduckgo.com/?q={}",
        "wa": "https://wiki.archlinux.org/?search={}",
    },
)
config.set("url.start_pages", "file:///home/pallav/.config/startpage/index.html")
config.set("content.local_content_can_access_remote_urls", True)
config.set("colors.contextmenu.disabled.bg", "#2E3440")
config.set("colors.contextmenu.disabled.fg", "#4C566A")
config.set("colors.contextmenu.menu.bg", "#3B4252")
config.set("colors.contextmenu.menu.fg", "#E5E9F0")
config.set("colors.contextmenu.selected.bg", "#4C566A")
config.set("colors.contextmenu.selected.fg", "#81A1C1")
config.set("colors.tabs.selected.odd.fg", "#e5e9f0")

# Bindings for cycling through CSS stylesheets from Solarized Everything CSS:
# https://github.com/alphapapa/solarized-everything-css
config.bind(
    ",ap",
    'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/apprentice/apprentice-all-sites.css ""',
)
config.bind(
    ",dr",
    'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/darculized/darculized-all-sites.css ""',
)
config.bind(
    ",gr",
    'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/gruvbox/gruvbox-all-sites.css ""',
)
config.bind(
    ",sd",
    'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/solarized-dark/solarized-dark-all-sites.css ""',
)
config.bind(
    ",sl",
    'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/solarized-light/solarized-light-all-sites.css ""',
)
config.bind("tcc", "config-cycle content.cookies.store TRUE FALSE")
