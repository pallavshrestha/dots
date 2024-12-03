config.set("colors.webpage.bg", "#3B4252")  # 93a1a1
config.set("colors.webpage.preferred_color_scheme", "dark")
config.set("colors.webpage.darkmode.enabled", False)
config.set("colors.webpage.darkmode.policy.images", "smart-simple")
config.set("colors.webpage.darkmode.algorithm", "lightness-cielab")
config.set("colors.webpage.darkmode.contrast", 0.00)
config.set("colors.webpage.darkmode.threshold.background", 100)
config.set("colors.webpage.darkmode.threshold.foreground", 150)
config.set("url.default_page", "file:///home/pallav/.config/startpage/index.html")
config.set(
    "url.searchengines",
    {
        "DEFAULT": "https://duckduckgo.com/?q={}",
        "brave": "https://search.brave.com/search?q={}",
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
config.set(
    "content.user_stylesheets",
    "~/.config/qutebrowser/solarized-everything-css/css/nord-dark-all-sites.css",
)

# Bindings for cycling through CSS stylesheets from Solarized Everything CSS:
# https://github.com/alphapapa/solarized-everything-css
config.bind(
    ",ap",
    'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/apprentice-all-sites.css ""',
)
config.bind(
    ",dr",
    'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/darculized-all-sites.css ""',
)
config.bind(
    ",gr",
    'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/gruvbox-all-sites.css ""',
)

config.bind(
    ",nd",
    'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/nord-dark-all-sites.css ""',
)

config.bind(
    ",sd",
    'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/solarized-dark-all-sites.css ""',
)
config.bind(
    ",sl",
    'config-cycle content.user_stylesheets ~/.config/qutebrowser/solarized-everything-css/css/solarized-light-all-sites.css ""',
)
config.bind("tcc", "config-cycle content.cookies.store TRUE FALSE")
