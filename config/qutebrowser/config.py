import os

from qutebrowser.config.configfiles import ConfigAPI
from qutebrowser.config.config import ConfigContainer
config: ConfigAPI = config
c: ConfigContainer = c

TERM = os.getenv('TERM')
EDITOR = os.getenv('EDITOR')

config.load_autoconfig(False)

config.bind('<tab>', 'nop')
config.bind('gh', 'set-cmd-text -s :help -t')

config.bind('gw', 'tab-give')

config.bind('u', 'scroll-page 0 -0.7')
config.bind('d', 'scroll-page 0 0.7')

config.bind('x', 'tab-close')
config.bind('X', 'undo')

config.bind(';i', 'hint images tab')
config.bind(';I', 'hint images download')

config.set('downloads.location.directory', '~/dl')
config.set('downloads.location.prompt', False)
config.set('downloads.location.remember', False)
config.set('downloads.position', 'bottom')
config.set('downloads.remove_finished', 3)

c.aliases['dl'] = 'spawn --userscript dl'
c.aliases['dlb'] = 'spawn --userscript dl -b'
config.bind('gd', 'set-cmd-text :dl ~/dl')
config.bind('gD', 'set-cmd-text :dlb ~/dl')

select_cmd = [TERM, '-e', 'lf', '-selection-path={}']
config.set('fileselect.handler', 'external')
config.set('fileselect.folder.command', select_cmd)
config.set('fileselect.single_file.command', select_cmd)
config.set('fileselect.multiple_files.command', select_cmd)

config.set('editor.command', [TERM, '-e', EDITOR, '{file}'])

config.set('tabs.show', 'multiple')
config.set('statusbar.show', 'in-mode')
config.set('content.notifications.enabled', False)

c.completion.favorite_paths = ['~/docs/wiki/html/']
