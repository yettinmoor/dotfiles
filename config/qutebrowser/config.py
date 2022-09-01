import os

from qutebrowser.config.configfiles import ConfigAPI
from qutebrowser.config.config import ConfigContainer
config: ConfigAPI = config
c: ConfigContainer = c

config.load_autoconfig(False)

config.bind('<tab>', 'nop')

# config.bind('<tab>', 'tab-next')
# config.bind('<Shift-tab>', 'tab-prev')

# config.bind('J', 'scroll-page 0 0.8')
# config.bind('K', 'scroll-page 0 -0.8')

config.set(
    'editor.command',
    [
        os.getenv('TERM'),
        '-e',
        os.getenv('EDITOR'),
        '{file}'
    ]
)

config.set('tabs.show', 'multiple')
config.set('statusbar.show', 'in-mode')

c.completion.favorite_paths = ['~/docs/wiki/html/']
