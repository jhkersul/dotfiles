# Kersul Dotfiles

These are my dotfiles.

It doesn't have the purpose to be general used,
but maybe you can get some insights to create yours.

## Required Packages

- Python 3
- pip 3
- ripgrep

## Omarchy (Linux)

Config for my [Omarchy](https://omarchy.org/) machine — Arch + Hyprland.
The goal is a Mac-like keyboard feel, so muscle memory carries over from the
macOS side of this repo: Super (Cmd) does app-level shortcuts, Alt (Option)
does window-manager things.

| File | Copy to |
| --- | --- |
| `omarchy/bindings.lua` | `~/.config/hypr/bindings.lua` |
| `omarchy/hid_apple.conf` | `/etc/modprobe.d/hid_apple.conf` (root) |
| `omarchy/zshrc` | `~/.zshrc` |
| `omarchy/starship.toml` | `~/.config/starship.toml` |

Hyprland auto-reloads on save. Validate with `hyprctl configerrors` after any
change, and see current bindings with `omarchy menu keybindings --print`.

### Keychron K1: swapping Option and Command

The K1 stays on the **Windows** side of its Mac/Win slider, so the Windows
dual-boot gets a keyboard that matches what it expects. That leaves the
modifiers backwards from the printed legends under Linux — the key labelled
Command sends Alt, and Option sends Super.

`hid_apple.conf` fixes it Linux-side only:

```
options hid_apple fnmode=2 swap_opt_cmd=1
```

Over Bluetooth the K1 advertises Apple's vendor ID (`05AC:024F`), so the kernel
binds it to the `apple` HID driver, which offers `swap_opt_cmd` for exactly
this. The driver reads the flag per key event, so it can be flipped live
without a reboot or re-pair:

```sh
echo 1 | sudo tee /sys/module/hid_apple/parameters/swap_opt_cmd
```

`hid_apple` isn't in the initramfs here, so `modprobe.d` alone makes it stick —
no `mkinitcpio -P` needed. Caveats: the flag is per-driver, not per-device, so
any other Apple-vendor keyboard gets the same swap. And if the slider ever goes
back to **Mac**, set this to `0` or the two swaps cancel out.

`fnmode=2` was already there — F-row sends media keys by default, hold Fn for
F1–F12, same as a real Mac. `fnmode=1` inverts that.

### Keybindings

`bindings.lua` only holds overrides; Omarchy's defaults load first and are left
alone where they already do the right thing (`SUPER + C/V/X` for
copy/paste/cut).

| Binding | Action | Was |
| --- | --- | --- |
| `SUPER + A` | Select all — sends `CTRL + A` | unbound |
| `SUPER + T` | New tab — sends `CTRL + T` | Toggle floating/tiling |
| `SUPER + W` | Close tab — sends `CTRL + W` | Close window |
| `SUPER + Q` | Close window | unbound |
| `SUPER + 1`…`9` | Switch to tab 1–8, 9 = last tab | `SUPER + 1`…`0` workspaces |
| `ALT + W` | Float as a fixed-size panel, top centre | unbound |
| `ALT + H/J/K/L` | Focus window left/down/up/right | `SUPER +` arrows |
| `ALT + SHIFT + H/J/K/L` | Swap window left/down/up/right | `SUPER + SHIFT +` arrows |
| `ALT + 1`…`0` | Switch to workspace 1–10 | `SUPER + 1`…`0` |
| `SUPER + SHIFT + W` | Reboot into Windows | Omawrite |

Moving workspaces to `ALT` freed the `SUPER` number row, which now does tab
switching by injecting `CTRL + 1`…`9` — so `SUPER + 1`…`9` matches Cmd+1…9 on
macOS, last-tab-on-9 included. `SUPER + 0` is left free (Cmd+0 is reset-zoom on
macOS, i.e. `CTRL + 0`, if that's ever wanted).

`ALT + W` doesn't just toggle floating — it floats the window as a fixed
`1600x1000` panel pinned to the top centre of the monitor, and tiles it back on a
second press. Adjust `FLOAT_WIDTH` / `FLOAT_HEIGHT` / `FLOAT_GAP` at the top of
that block. Two things it has to get right: geometry is applied on the next tick
via `hl.timer`, because Hyprland floats asynchronously and the size won't stick
otherwise; and the logical monitor size is *rounded*, since dividing by a
fractional scale is inexact (this display is 3840x2160 at scale 1.6, and
`3840 / 1.6` evaluates to 2399.99996 — enough to lose a pixel when centring).

Floating windows are otherwise moved and resized with `SUPER +` left-drag and
`SUPER +` right-drag, plus Omarchy's `SUPER + -` / `SUPER + =` resize bindings
(add `SHIFT` for height, `ALT` for 25px steps, `CTRL` for 300px). There is no
default *keyboard* binding for moving a float.

`ALT + SHIFT + L` shadows Omarchy's "Copy URL from Web App", which is a Chromium
*extension* shortcut rather than a Hyprland binding — the keybindings menu lists
it, but `hyprctl binds` doesn't, and Hyprland claims the chord before the browser
ever sees it. Only the arrow bindings replaced by `H/J/K/L` were unbound; the
group moves on `SUPER + ALT +` arrows, monitor moves on `SUPER + SHIFT + ALT +`
arrows, and grouped focus on `SUPER + CTRL +` arrows are all still there.

Hyprland can't translate one chord into another, so the "universal" bindings
inject the target chord into the focused surface with `send_key_state`, copying
the approach in `/usr/share/omarchy/default/hypr/bindings/clipboard.lua`. Two
details from there matter: a virtual keyboard (`wtype`) doesn't work because the
physically held Super merges into the injected chord at the seat, and the
down/up split works around Hyprland occasionally leaving synthetic key state
stuck ([Hyprland#14099](https://github.com/hyprwm/Hyprland/discussions/14099)).

Known rough edge: the injected chords are unconditional, so in a terminal they
reach readline instead of closing or opening anything — `CTRL + T` transposes
characters, and `CTRL + W` rubs out the previous word. Either bind `super+t` and
`super+w` in the terminal itself so they never reach the shell, or neutralise
them in `~/.inputrc`:

```
"\C-t": self-insert
"\C-w": self-insert
```

Workspace switching uses the `code:10`–`code:19` keycode form rather than
literal `"1"`–`"0"`, matching Omarchy's default so it survives a layout change.

### Not captured here

`~/.config/hypr/input.lua` carries a `caps:swapescape` override (Caps Lock on
the physical Escape key). Predates this folder — worth copying in if this
machine ever gets rebuilt.

### Shell: zsh

Running zsh via [`omarchy-zsh`](https://github.com/omacom-io/omarchy-zsh), the
officially maintained Omarchy zsh port — so `omarchy update` keeps it working
rather than fighting it.

```sh
omarchy pkg add omarchy-zsh zsh-autosuggestions zsh-history-substring-search
omarchy-setup-zsh
git clone https://github.com/jhkersul/zsh-git-aliases ~/.zsh/zsh-git-aliases
# then copy omarchy/zshrc over ~/.zshrc
```

`omarchy-setup-zsh` does **not** run `chsh`. The login shell stays `/usr/bin/bash`
and `~/.bashrc` becomes a stub that `exec zsh`s for interactive shells — so a
broken zsh config can't lock you out. It overwrites both rc files, backing them
up as `.bashrc.backup-*` / `.zshrc.backup-*` first; the Cloudflare env line at
the bottom of `zshrc` was carried over from the old `~/.bashrc` that way.

Four additions on top of omarchy-zsh's defaults:

| Want | How |
| --- | --- |
| vi mode | `bindkey -v` plus `KEYTIMEOUT=1`. Must come *after* omarchy-zsh's `zoptions`, which ends on `bindkey -e` |
| History substring search | `zsh-history-substring-search`, bound to ↑/↓ and to `k`/`j` in vicmd |
| Autosuggestions | `zsh-autosuggestions`, accepted with `Ctrl+L` |
| `gst` and friends | [`zsh-git-aliases`](https://github.com/jhkersul/zsh-git-aliases) — oh-my-zsh's 197 git aliases, standalone |

Ordering is load-order sensitive, hence the comments in the file:

- `bindkey -v` after `zoptions`, or emacs mode wins.
- The ↑/↓ rebinding after `zoptions` too, which binds them to *prefix* search.
- `zsh-history-substring-search` after `zsh-syntax-highlighting` (which
  omarchy-zsh sources at the end of `zoptions`), as its README requires for
  match highlighting.
- vi insert mode drops several emacs editing keys, so `^A ^E ^K ^U ^W ^R` are
  re-bound in `viins`. `^?` especially: without it backspace won't delete past
  wherever insert mode started.

**One alias changes meaning.** omarchy-zsh has `gcm='git commit -m'`; oh-my-zsh
has `gcm='git checkout $(git_main_branch)'` and puts commit-with-message on
`gcmsg`. `zsh-git-aliases` is sourced last, so oh-my-zsh wins — matching the
macOS muscle memory this whole setup is built around. There's a commented-out
line in `zshrc` to flip it back. `gcam` means the same thing in both, and
omarchy's `gcad` is untouched since oh-my-zsh doesn't define it.

`Ctrl+L` is autosuggest-accept, so it no longer clears the screen — use `clear`.

`starship.toml` gains `vimcmd_symbol`, a yellow `❮` shown while vi normal mode is
active. Starship's zsh integration installs `starship_zle-keymap-select`, so this
needs no extra plugin.
