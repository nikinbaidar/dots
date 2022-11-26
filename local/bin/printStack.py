#!/usr/bin/env python

import json
import lz4.block
import pathlib
import sys

'''
Sets the stack order of specific elements is known as the z-index. An element
with greater stack order is always in front of another element that has a lower
stack order.

Run more tests more before finalizing anything.
'''


def getAllUrl():
  for f in files:
    b = f.read_bytes()
    if b[:8] == b'mozLz40\0':
        j = json.loads(lz4.block.decompress(b[8:]))
        return { window['zIndex']:  [ tab['entries'][tab['index'] - 1]['url'] \
            for tab in window['tabs'] ] for window in j['windows'] }
    return None


def getTabIndex(localURL):
  x = getAllUrl()
  for item in x.values():
    if localURL in item:
      print(item)
      print(item.index(localURL) + 1)
  else:
    print(0)


def test():
  """
  1. Private windows are ignored.
  2. Older windows move higher on the stack as new windows spawn.
  """

  x = getAllUrl()
  for key in x.keys():
    print(key, ":", x[key])


def main():
  global files

  localURL = 'file:///home/nikin/.cache/mozilla/firefox/home.html'

  path = pathlib.Path.home().joinpath('.mozilla/firefox')
  files = path.glob('*.default*/sessionstore-backups/recovery.jsonlz4')

  # getTabIndex(localURL)
  test()

if __name__ == '__main__':
  main()
