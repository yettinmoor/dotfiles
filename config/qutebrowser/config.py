import os

from qutebrowser.config.configfiles import ConfigAPI
from qutebrowser.config.config import ConfigContainer
config: ConfigAPI = config
c: ConfigContainer = c

CONFIG = os.getenv('XDG_CONFIG_HOME')
EDITOR = os.getenv('EDITOR')
HOME = os.getenv('HOME')
TERM = os.getenv('TERM')

####

config.load_autoconfig(False)

# misc
config.set('url.default_page', os.getenv('HOMEPAGE'))
config.set('content.netrc_file', CONFIG + '/netrc')
config.set('content.notifications.enabled', False)
config.set('editor.command', [TERM, '-e', EDITOR, '{file}'])
config.set('tabs.show', 'multiple')
config.set('statusbar.show', 'in-mode')
config.set('content.notifications.enabled', False)
try:
    c.completion.favorite_paths = [os.path.join(os.getenv('WIKI_DIR'), 'html')]
except:
    pass

# basic rebinds
config.bind('<tab>', 'nop')
config.bind('gh', 'set-cmd-text -s :help -t')
config.bind('gw', 'tab-give')
config.bind('u', 'scroll-page 0 -0.6')
config.bind('d', 'scroll-page 0 0.6')
config.bind('x', 'tab-close')
config.bind('X', 'undo')
config.bind('cf', 'fake-key f')
config.bind('<ctrl-e>', 'config-edit')
config.bind('<ctrl-r>', 'config-source')

# media
config.set('content.autoplay', False)
config.bind(';i', 'hint images tab')
config.bind(';v', 'hint media download')
config.bind(',v', 'hint media spawn launch -x mpv {hint-url}')
config.bind(',V', 'spawn launch -x mpv {url}')
config.bind(',yt', 'spawn yt-dlp {url}')

# downloading
c.aliases['dl'] = 'spawn --userscript dl'
c.aliases['dlb'] = 'spawn --userscript dl -b'
config.bind('gd', 'set-cmd-text :dl ~/dl')
config.bind('gD', 'set-cmd-text :dlb ~/dl')
config.set('downloads.location.directory', os.path.join(HOME, 'dl'))
config.set('downloads.location.prompt', False)
config.set('downloads.location.remember', False)
config.set('downloads.position', 'bottom')
config.set('downloads.remove_finished', 3)

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
