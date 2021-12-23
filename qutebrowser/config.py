#Load autoconfig
config.load_autoconfig()

# Import Nord Color scheme
config.source('nord-qutebrowser.py')

#Hotkey for mpv spawn
config.bind(',m', 'spawn umpv {url}')
config.bind(',M', 'hint links spawn umpv {hint-url}')
config.bind (';M', 'hint --rapid links spawn umpv {hint-url}')

#Hotkeys for translate
config.bind(',t', 'hint userscript link translate')
config.bind(',T', 'hint userscript all translate --text')
config.bind('<Alt+t>', 'spawn --userscript translate')
config.bind('<Alt+Shift+t>', 'spawn --userscript translate --text')

#Blocking adblock on a specific website
config.set('content.blocking.enabled',True)
config.set('content.blocking.enabled', False, '*://rockpapershotgun/')

#Cookies blocking and exceptions
config.set('content.cookies.accept', 'never')
config.set('content.cookies.store', True)

#Cookies exceptions
config.set('content.cookies.accept', 'all','*://*.google.com/*')
config.set('content.cookies.accept', 'all','*://*.reddit.com/*')
config.set('content.cookies.accept', 'all','*://web.telegram.org/*')
config.set('content.cookies.accept', 'all','*://web.whatsapp.com/*')
config.set('content.cookies.accept', 'all','*://*.youtube.com/*')
config.set('content.cookies.accept', 'all','*://*.epicgames.com/*')
config.set('content.cookies.accept', 'all','*://*.gog.com/*')
config.set('content.cookies.accept', 'all','*://*.facebook.com/*')
config.set('content.cookies.accept', 'all','*://fs.lut.fi/*')
config.set('content.cookies.accept', 'all','*://*.duosecurity.com/*')
config.set('content.cookies.accept', 'all','*://*.microsoftonline.com/')
config.set('content.cookies.accept', 'all','*://office/')
config.set('content.cookies.accept', 'all','*://bestware.com/*')
config.set('content.cookies.accept', 'all','*://github.com/*')

#Use vim to edit specific line #Not working for some reason, probably some fix required
#config.set("vim", "-f", "{file}", "-c", "normal {line}G{column0}l")


