import os

from qutebrowser.config.configfiles import ConfigAPI
from qutebrowser.config.config import ConfigContainer
config: ConfigAPI = config
c: ConfigContainer = c

CONFIG = os.getenv('XDG_CONFIG_HOME')
EDITOR = os.getenv('EDITOR')
HOME = os.getenv('HOME')
TERM = os.getenv('TERM')
WIKI_DIR = os.getenv('WIKI_DIR')

assert CONFIG is not None
assert EDITOR is not None
assert HOME is not None
assert TERM is not None
assert WIKI_DIR is not None

####

config.load_autoconfig(False)
config.bind('<ctrl-e>', 'config-edit')
config.bind('<ctrl-r>', 'config-source')

# basic settings
config.set('url.default_page', os.getenv('HOMEPAGE'))
config.set('content.netrc_file', CONFIG + '/netrc')
config.set('content.notifications.enabled', False)
config.set('editor.command', [TERM, '-e', EDITOR, '{file}'])
config.set('content.notifications.enabled', False)
c.completion.favorite_paths = [os.path.join(WIKI_DIR, 'html')]

# basic rebinds
config.bind('<tab>', 'nop')
config.bind('gh', 'set-cmd-text -s :help -t')
config.bind('u', 'scroll-page 0 -0.5')
config.bind('d', 'scroll-page 0 0.5')
config.bind('cf', 'fake-key f')

# statusbar shenanigans
config.bind('<ctrl-b>', 'config-cycle statusbar.show always in-mode')
config.bind(':', 'set statusbar.show always;; set-cmd-text :')
config.bind('/', 'set statusbar.show always;; set-cmd-text /')
config.bind(
    '<Escape>', 'mode-enter normal;; set statusbar.show in-mode', mode='command')
config.bind(
    '<Return>', 'command-accept;; set statusbar.show in-mode', mode='command')

# tabs
config.set('tabs.show', 'multiple')
config.bind('gw', 'tab-give')
config.bind('x', 'tab-close')
config.bind('X', 'undo')
config.bind('<', 'tab-move -')
config.bind('>', 'tab-move +')

# media
config.set('content.autoplay', False)
config.bind('gm', 'spawn launch -dx mpv --profile=ytdl {url}')
config.bind(',m', 'hint links spawn launch -dx mpv --profile=ytdl {hint-url}')

# downloading
c.aliases['dl'] = 'spawn --userscript qutedl'
config.bind('gd', 'set-cmd-text :dl ~/dl')
config.bind('gD', 'set-cmd-text :dl -b ~/dl')
config.bind('gv', 'set-cmd-text :dl -v ~/dl')
config.bind('gV', 'set-cmd-text :dl -bv ~/dl')
config.bind(',d', 'hint links fill :dl -u {hint-url} ~/dl')
config.bind(',D', 'hint links fill :dl -b -u {hint-url} ~/dl')
config.bind(',v', 'hint links fill :dl -v -u {hint-url} ~/dl')
config.bind(',V', 'hint links fill :dl -bv -u {hint-url} ~/dl')
config.bind(',i', 'hint images fill :dl -u {hint-url} ~/dl')
config.bind(',I', 'hint images fill :dl -b -u {hint-url} ~/dl')
config.set('downloads.location.directory', os.path.join(HOME, 'dl'))
config.set('downloads.location.prompt', False)
config.set('downloads.location.remember', False)
config.set('downloads.position', 'bottom')
config.set('downloads.remove_finished', 2000)

# file picker
select_cmd = [TERM, '-e', 'lf', '-selection-path={}']
config.set('fileselect.handler', 'external')
config.set('fileselect.folder.command', select_cmd)
config.set('fileselect.single_file.command', select_cmd)
config.set('fileselect.multiple_files.command', select_cmd)

# adblock
c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
    "https://easylist.to/easylist/fanboy-annoyance.txt",
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt"
]
c.content.blocking.enabled = True
c.content.blocking.hosts.lists = [
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts']
c.content.blocking.method = 'both'
