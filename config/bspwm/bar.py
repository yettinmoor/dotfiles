#!/usr/bin/env python3

import time

from subprocess import Popen, PIPE
from queue import Queue
from threading import Thread

msgs = Queue()


def update():
    components = {
        'desktops': '',
        'title': '',
    }
    while True:
        fn, msg = msgs.get()
        components[fn] = msg
        bar = components['desktops'] + ' :: ' + components['title']
        print(bar, flush=True)


def bspwm_title():
    from Xlib import X
    from Xlib.display import Display

    disp = Display()

    NET_ACTIVE_WINDOW = disp.intern_atom('_NET_ACTIVE_WINDOW')
    NET_WM_NAME = disp.intern_atom('_NET_WM_NAME')

    root = disp.screen().root
    disp.screen().root.change_attributes(event_mask=X.PropertyChangeMask)

    def window_obj(win_id):
        try:
            return disp.create_resource_object('window', win_id)
        except:
            return None

    response = root.get_full_property(
        NET_ACTIVE_WINDOW, X.AnyPropertyType)
    if response:
        w = window_obj(response.value[0])

    while True:
        new_name = None
        ev = disp.next_event()

        if ev.type != X.PropertyNotify:
            continue

        if ev.atom == NET_ACTIVE_WINDOW:
            response = root.get_full_property(
                NET_ACTIVE_WINDOW, X.AnyPropertyType)
            if not response:
                continue

            if w:
                w.change_attributes(event_mask=X.NoEventMask)

            w = window_obj(response.value[0])
            if w:
                try:
                    w.change_attributes(event_mask=X.PropertyChangeMask)
                    new_name = w.get_full_property(
                        NET_WM_NAME, 0).value.decode()
                except:
                    w = None
                    new_name = ''
        elif ev.atom == NET_WM_NAME and w:
            new_name = w.get_full_property(NET_WM_NAME, 0).value.decode()

        if new_name is not None:
            msgs.put(('title', new_name))


def bspwm_desktops():
    FOCUSED_FG = '#111111'
    FOCUSED_BG = '#daab62'
    URGENT_FG = '#34322e'
    URGENT_BG = '#f9a299'

    def color(s, fg, bg):
        return f'^fg({fg})^bg({bg}){s}^fg()^bg()'

    with Popen(['bspc', 'subscribe', 'report'], stdout=PIPE) as bspc:
        while line := bspc.stdout.readline():
            line = line.decode('ascii').strip()
            output = ''
            for field in line.split(':'):
                state, *num = field
                num = ''.join(num)
                s = f'^ca(1,bspc desktop -f {num}) {num} ^ca()'
                match state:
                    case 'O' | 'F' | 'U':
                        output += color(s, FOCUSED_FG, FOCUSED_BG)
                    case 'o':
                        output += s
                    case 'u':
                        output += color(s, URGENT_FG, URGENT_BG)
                    case _:
                        continue
            msgs.put(('desktops', output))


if __name__ == '__main__':
    threads = [
        Thread(target=update),
        Thread(target=bspwm_desktops),
        Thread(target=bspwm_title),
    ]
    for t in threads:
        t.start()
    for t in threads:
        t.join()
