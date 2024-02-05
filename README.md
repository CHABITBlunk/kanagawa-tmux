# Kanagawa Tmux

A clean, dark Tmux theme based off of Hokusai Katsushika's painting,
[The Great Wave off Kanagawa](https://github.com/rebelot/kanagawa.nvim)
The perfect companion for [tokyonight-vim](https://github.com/ghifarit53/tokyonight-vim)
Adapted from the original, [Visual Studio Code theme](https://github.com/enkia/tokyo-night-vscode-theme).
The old version (deprecated) is still available in the `legacy` branch.

## About this theme

This is a very opinionated project, as I am a Tech Lead, this theme is very developer-focused.

## Requirements

### Nerd Fonts

This theme requires the use of a patched font with Nerd Font. Ensure your
terminal is set to use one before installing this theme. Any patched font will
do. See [`nerdfonts.com`](https://www.nerdfonts.com/) for more informations.

### Noto Fonts

This theme requires the Noto fonts to be installed on your operating system.
Make sure your operating system has the needed font and is configured to use one.

### Installation using TPM

In your `tmux.conf`:

```tmux
set -g @plugin "chabitblunk/kanagawa-tmux"
```

### Configuration

#### Number styles

Run this

```bash
tmux set @tokyo-night-tmux_window_id_style digital
tmux set @tokyo-night-tmux_pane_id_style hsquare
tmux set @tokyo-night-tmux_zoom_id_style dsquare
```

or add this lines to your  `.tmux.conf`

```tmux
set -g @tokyo-night-tmux_window_id_style digital
set -g @tokyo-night-tmux_pane_id_style hsquare
set -g @tokyo-night-tmux_zoom_id_style dsquare
```

The styles:

- `none`: no style, default font
- `digital`: 7 segment number (🯰...🯹) (needs [Unicode support](https://github.com/janoamaral/tokyo-night-tmux/issues/36#issuecomment-1907072080)) 
- `roman`: roman numbers (󱂈...󱂐) (needs nerdfont)
- `fsquare`: filled square (󰎡...󰎼) (needs nerdfont)
- `hsquare`: hollow square (󰎣...󰎾) (needs nerdfont)
- `dsquare`: hollow double square (󰎡...󰎼) (needs nerdfont)
- `super`: superscript symbol (⁰...⁹)
- `sub`: subscript symbols (₀...₉)

### New tokyonight Highlights ⚡

Everything works out the box now. No need to modify anything and colors are hard-
coded, so it's independent of terminal theme.

- Local git stats.
- Web based git server (GitHub/GitLab) stats.
  - Open PR count
  - Open PR reviews count
  - Issue count
- Remote branch sync indicator (you will never forget to push or pull again 🤪).
- Great terminal icons.
- Prefix highlight incorporated.
- Now Playing status bar, supporting [cmus]/[nowplaying-cli]
- Windows has custom pane number indicator.
- Pane zoom mode indicator.
- Date and time.

#### TODO

- Add configurations
  - remote fetch time
  - ~number styles~
  - indicators order
  - disable indicators

### Snapshots

- Terminal: Kitty with [Tokyo Night Kitty Theme](https://github.com/davidmathers/tokyo-night-kitty-theme)
- Font: [SFMono Nerd Font Ligaturized](https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized)

[cmus]: https://cmus.github.io/
[nowplaying-cli]: https://github.com/kirtan-shah/nowplaying-cli
