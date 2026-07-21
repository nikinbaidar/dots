# README

## IPython

In `~/.ipython/profile_default/ipython_config.py`, set

```
pythonc.InteractiveShell.colors = 'Linux'
c.TerminalInteractiveShell.colors = 'Linux'
```

## keyd

Install `keyd` then ~~create symlink~~ copy `/misc/HARDWARE/keyd/` to `/etc` and
enable the service.

For application specific mapping don't forget to add `$USER` to the `keyd` group.

Useful commands for keyd:

1. `keyd monitor`
1. `keyd reload`

## Symlinks I Create Once And Forget

These handle `caps:esc` swap on tty.

1. `local/share/kbd/keymaps/us.map-custom.gz` inside `/usr/local/share/kbd/keymaps`.
1. `misc/HARDWARE/vconsole.conf` inside `/etc`.

