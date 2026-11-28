# hermes

a small practical Wayland terminal, based on [havoc](https://github.com/ii8/havoc)

## build

requires Wayland development libraries, xkbcommon, fontconfig, wayland-protocols and wayland-scanner.

```sh
make
make install
```

## usage

```text
hermes -c path/to/config   use a configuration file
hermes -l                  keep the window open after the child exits
hermes -h                  help
hermes -v                  version
```

`ctrl shift +` and `ctrl shift -` change font size;
`ctrl shift r` resets it.

## what is here
- terminal mouse reporting for tui program
- reliable pty and clipboard output
- window sizing that follows the compositor
- scrollback and sensible key bindings by default

see `hermes.cfg` for configuration options.

## license

isc, see LICENSE

## origin

hermes is a fork of [havoc](https://github.com/ii8/havoc)
