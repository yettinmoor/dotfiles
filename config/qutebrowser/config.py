import os

from qutebrowser.config.configfiles import ConfigAPI
from qutebrowser.config.config import ConfigContainer
config: ConfigAPI = config
c: ConfigContainer = c

CONFIG = os.getenv('XDG_CONFIG_HOME')
EDITOR = os.getenv('EDITOR')
HOME = os.getenv('HOME')
TERMINAL = os.getenv('TERMINAL')
WIKI_DIR = os.getenv('WIKI_DIR')

assert CONFIG is not None
assert EDITOR is not None
assert HOME is not None
assert TERMINAL is not None
assert WIKI_DIR is not None

CSS = CONFIG + '/qutebrowser/css/gruvbox.css'

hostname = os.uname().nodename
is_big_monitor = hostname in ['medea']

####

config.load_autoconfig(False)
config.bind('<ctrl-e>', 'config-edit')
config.bind('<ctrl-r>', 'config-source')

# basic settings
config.set('fonts.default_size', '20pt' if is_big_monitor else '12pt')
config.set('zoom.default', '150%' if is_big_monitor else '100%')
config.set('url.default_page', os.getenv('HOMEPAGE'))
config.set('content.netrc_file', CONFIG + '/netrc')
config.set('content.notifications.enabled', False)
config.set('editor.command', [TERMINAL, '-e', EDITOR, '{file}'])
config.set('content.notifications.enabled', False)
config.set('content.tls.certificate_errors', 'ask-block-thirdparty')
c.completion.favorite_paths = [os.path.join(WIKI_DIR, 'html')]

# hints
config.set('hints.chars', 'qwerasdf')

# aesth
# config.set('colors.webpage.darkmode.enabled', True)
# config.set('content.user_stylesheets', CSS)
config.bind('<ctrl-m>', f'config-cycle content.user_stylesheets "{CSS}" ""')
config.set('fonts.web.family.fixed', 'mono')
config.set('fonts.web.family.sans_serif', 'sans-serif')
config.set('fonts.web.family.serif', 'serif')


# basic rebinds
config.bind('<tab>', 'nop')
config.bind('gh', 'cmd-set-text -s :help -t')
config.bind('u', 'scroll-page 0 -0.5')
config.bind('d', 'scroll-page 0 0.5')
config.bind('cf', 'fake-key f')
config.bind('gH', 'spawn -u his')
config.bind('<alt-v>', 'cmd-set-text --append -- {clipboard}', mode='command')

# statusbar shenanigans
config.bind('<ctrl-b>', 'config-cycle -t statusbar.show in-mode always')
# config.bind(':', 'set statusbar.show always;; cmd-set-text :')
# config.bind('/', 'set statusbar.show always;; cmd-set-text /')
# config.bind(
#     '<Escape>', 'mode-enter normal;; set statusbar.show in-mode', mode='command')
# config.bind(
#     '<Return>', 'command-accept;; set statusbar.show in-mode', mode='command')

# tabs
config.set('tabs.show', 'multiple')
config.bind('gw', 'tab-give')
config.bind('x', 'tab-close')
config.bind('X', 'undo')
config.bind('<', 'tab-move -')
config.bind('>', 'tab-move +')
config.bind('gc', 'tab-clone')

# media
config.set('content.autoplay', False)
config.bind('gm', 'spawn launch -dx mpv --profile=ytdl {url}')
config.bind(',m', 'hint links spawn launch -dx mpv --profile=ytdl {hint-url}')
config.bind('gM', 'spawn launch -x mpv --profile=ytdl {url}')
config.bind(',M', 'hint links spawn launch -x mpv --profile=ytdl {hint-url}')

# downloading
config.bind('gd', 'spawn qdl {url:pretty}')
config.bind('gD', 'spawn qdl -s {url:pretty}')
config.bind('gv', 'spawn qdl -v {url:pretty}')
config.bind('gV', 'spawn qdl -sv {url:pretty}')
config.bind('ga', 'spawn qdl -a {url:pretty}')
config.bind('gA', 'spawn qdl -sa {url:pretty}')
config.bind(',d', 'hint links spawn qdl {hint-url}')
config.bind(',D', 'hint links spawn qdl -s {hint-url}')
config.bind(',v', 'hint links spawn qdl -v {hint-url}')
config.bind(',V', 'hint links spawn qdl -sv {hint-url}')
config.bind(',a', 'hint links spawn qdl -a {hint-url}')
config.bind(',A', 'hint links spawn qdl -sa {hint-url}')
config.bind(',i', 'hint media spawn qdl {hint-url}')
config.bind(',I', 'hint media spawn qdl -s {hint-url}')

config.set('downloads.location.directory', os.path.join(HOME, 'dl'))
config.set('downloads.location.prompt', False)
config.set('downloads.location.remember', False)
config.set('downloads.position', 'bottom')
config.set('downloads.remove_finished', 5000)

# file picker
select_file_cmd = [TERMINAL, '-e', 'lf', '-selection-path={}']
select_dir_cmd = [TERMINAL, '-c', 'Dirpick', '-e', 'sh', '-c', 'dirpick > {}']
# config.set('fileselect.handler', 'external')
# config.set('fileselect.folder.command', select_dir_cmd)
# config.set('fileselect.single_file.command', select_file_cmd)
# config.set('fileselect.multiple_files.command', select_file_cmd)

# onion
config.bind(
    '<ctrl-t>',
    'config-cycle --print content.proxy "system" "socks://localhost:9050/"'
)

# adblock
c.content.blocking.adblock.lists = [
    "https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt",
    "https://easylist-downloads.adblockplus.org/easylistdutch.txt",
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://easylist.to/easylist/fanboy-annoyance.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt",
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
    "https://www.i-dont-care-about-cookies.eu/abp/"
]
c.content.blocking.enabled = True
c.content.blocking.hosts.lists = [
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts']
c.content.blocking.method = 'both'
