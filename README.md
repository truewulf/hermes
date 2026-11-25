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
hermes                     start
hermes -c path/to/config   use a configuration file
hermes -l                  keep the window open after the child exits
hermes -h                  help
hermes -v                  version
```

hold shift to use local selection and scrollback when an application captures
the mouse. `ctrl+shift++` and `ctrl+shift+-` change font size;
`ctrl+shift+r` resets it.

## what is here

- automatic system monospace font, with fallback fonts for missing symbols;
- icons for nnn, neovim and other programs when a nerd font is installed;
- terminal mouse reporting for tui programs;
- reliable pty and clipboard output;
- window sizing that follows the compositor;
- scrollback and sensible key bindings by default.

see `hermes.cfg` for configuration options. hermes works without a config
file and does not create one automatically.

## license

isc, see LICENSE

## thanks

thanks to [havoc](https://github.com/ii8/havoc) and its contributors for the
foundation.
