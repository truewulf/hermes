# hermes

small practical terminal for wayland

## build

install the development files for wayland-client, wayland-cursor, xkbcommon
and fontconfig, plus wayland-protocols and wayland-scanner.

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

## thanks

thanks to [havoc](https://github.com/ii8/havoc) and its contributors for the
foundation.
