#!/usr/bin/env python3

import json
import lz4.block
import pathlib
import sys

'''
z-index changes when browser tab gets reloaded. The z-index of that window
whose tab was most recently reloaded will be higher. (z-index doesn't remain
constant as new window spwan.)
REMEMBER:

1. Private windows are ignored.
2. Older windows move higher on the stack as new windows spawn. 
1.  Higher the window is in the stack, the more time it has been in the stack.

XXX: Run more tests more before finalizing anything.
'''


def getUrlTable():
  path = pathlib.Path.home().joinpath('.mozilla/firefox')
  files = path.glob('*.default*/sessionstore-backups/recovery.jsonlz4')

  for f in files:
    b = f.read_bytes()
    if b[:8] == b'mozLz40\0':
        j = json.loads(lz4.block.decompress(b[8:]))
        return { 
                window['zIndex'] :  [ tab['entries'][tab['index'] - 1]['url'] \
                    for tab in window['tabs'] ] for window in j['windows'] 
                }
    return None


def main(localURL):
  """ 
  * Checks if the given localURL is open in ANY browser window. If so, prints
  that window's position in the stack and, also prints the tab position of the
  URL in that window. 
  * Otherwise prints None.
  """

  x = getUrlTable()

  if isinstance(x, dict) and localURL in sum(x.values(), []):
    for window in x.keys():
      if localURL in x[window]:
        print(x[window].index(localURL)+1)
        break
  else:
    print(None)

if __name__ == '__main__':
    main(sys.argv[1])
