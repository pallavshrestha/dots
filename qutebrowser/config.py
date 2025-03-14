# Load autoconfig
config.load_autoconfig(False)

config.bind("ch", "history-clear")

# Import Nord Color scheme
config.source("nord-qutebrowser.py")
config.source("general-settings.py")

# Hotkey for mpv spawn
config.bind(",M", "spawn umpv {url}")
config.bind(",m", "hint links spawn umpv {hint-url}")
config.bind(";M", "hint --rapid links spawn umpv {hint-url}")

# Hotkeys for translate
config.bind(",t", "hint userscript link translate")
config.bind(",T", "hint userscript all translate --text")
config.bind("<Alt+t>", "spawn --userscript translate")
config.bind("<Alt+Shift+t>", "spawn --userscript translate --text")

# Blocking adblock on a specific website
config.set("content.blocking.enabled", True)
config.set("content.blocking.enabled", False, "*://*.rockpapershotgun.com/")

# Cookies blocking and exceptions
config.set("content.cookies.accept", "never")
config.set("content.cookies.store", False)
# config.set('content.headers.user_agent','Mozilla/5.0 (Windows NT 10.0; rv:109.0) Gecko/20100101 Firefox/117.0')
# Cookies exceptions
config.source("cookies-whitelist.py")
config.bind(",s", "cmd-set-text -s :session-load -c ")


# Use vim to edit specific line
# Not working for some reason, probably some fix required
# config.set("vim", "-f", "{file}", "-c", "normal {line}G{column0}l")

# ================== Youtube Add Blocking ======================= {{{
from qutebrowser.api import interceptor


def filter_yt(info: interceptor.Request):
    """Block the given request if necessary."""
    url = info.request_url
    if url.host() == "www.youtube.com" and url.path() == "/get_video_info" and "&adformat=" in url.query():
        info.block()


interceptor.register(filter_yt)
# }}}
