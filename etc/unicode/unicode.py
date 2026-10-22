#!/usr/bin/env python

import sys

if len(sys.argv) < 2:
    print('usage: %s <filename>' % sys.argv[0])
    exit(1)

filename = sys.argv[1]
for l in open(filename).readlines():
    fs = l.split(';')
    cp, name = fs[0], fs[1].lower()
    if name.startswith('<') or name == 'space': continue
    try:
        print(chr(int(cp, 16)), name)
    except UnicodeEncodeError as e:
        # print('error:', e, cp, name)
        pass
