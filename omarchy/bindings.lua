-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Reboot into Windows (runs in a terminal so sudo can prompt for a password).
-- Note: SUPER+SHIFT+W was previously bound to Omawrite.
hl.unbind("SUPER + SHIFT + W")
o.bind("SUPER + SHIFT + W", "Reboot to Windows", "omarchy launch terminal /home/kersul/Develop/dotfiles/scripts/go-to-windows.sh")

-- Universal select all: SUPER + A sends CTRL + A to the focused surface, so the
-- Super key covers select-all the way Cmd does on macOS. Mirrors the down/up
-- split used by Omarchy's universal copy/paste/cut in
-- $OMARCHY_PATH/default/hypr/bindings/clipboard.lua -- a virtual keyboard
-- (wtype) won't do, because the physically held SUPER merges into the injected
-- chord at the seat.
local function send_shortcut_once(mods, key)
  return function()
    hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "down" }))

    hl.timer(function()
      hl.dispatch(hl.dsp.send_key_state({ mods = mods, key = key, state = "up" }))
    end, { timeout = 50, type = "oneshot" })
  end
end

o.bind("SUPER + A", "Universal select all", send_shortcut_once("CTRL", "A"))

-- Universal new tab: SUPER + T sends CTRL + T to the focused surface, the way
-- Cmd+T does on macOS.
-- Note: SUPER+T was previously bound to "Toggle window floating/tiling", which
-- now lives on ALT+W (the physical Option key, post opt/cmd swap).
hl.unbind("SUPER + T")
o.bind("SUPER + T", "Universal new tab", send_shortcut_once("CTRL", "T"))

-- ALT + W floats the active window as a fixed-size panel pinned to the top
-- centre of the monitor; pressing it again tiles the window back. Sizes are
-- logical pixels (this monitor is 3840x2160 at scale 1.6, so 2400x1350).
local FLOAT_WIDTH = 1600
local FLOAT_HEIGHT = 1000
local FLOAT_GAP = 12

o.bind("ALT + W", "Float window top centre", function()
  local window = hl.get_active_window()
  if not window then
    return
  end

  local was_floating = window.floating
  hl.dispatch(hl.dsp.window.float({ action = "toggle" }))

  if was_floating then
    return
  end

  -- Hyprland applies the float asynchronously, so the geometry only sticks on
  -- the next tick -- same reason the universal shortcuts above use a timer.
  hl.timer(function()
    local monitor = hl.get_active_monitor()
    if not monitor then
      return
    end

    -- Logical size has to be rounded: dividing by a fractional scale is inexact
    -- (3840 / 1.6 comes back as 2399.99996), which otherwise costs a pixel when
    -- centring.
    local function round(value)
      return math.floor(value + 0.5)
    end

    local logical_width = round(monitor.width / monitor.scale)
    local logical_height = round(monitor.height / monitor.scale)
    local usable_height = logical_height - monitor.reserved.top - monitor.reserved.bottom

    local width = math.min(FLOAT_WIDTH, logical_width - 2 * FLOAT_GAP)
    local height = math.min(FLOAT_HEIGHT, usable_height - 2 * FLOAT_GAP)

    hl.dispatch(hl.dsp.window.resize({ x = round(width), y = round(height) }))
    hl.dispatch(hl.dsp.window.move({
      x = round(monitor.position.x + (logical_width - width) / 2),
      y = round(monitor.position.y + monitor.reserved.top + FLOAT_GAP),
    }))
  end, { timeout = 20, type = "oneshot" })
end)

-- Switch workspaces with ALT + 1..0 instead of SUPER + 1..0, freeing the Super
-- (Cmd) row for app-level shortcuts. Uses the same `code:` form as Omarchy's
-- default in $OMARCHY_PATH/default/hypr/bindings/tiling.lua, so it binds the
-- physical number-row keys regardless of keyboard layout.
-- Note: SUPER + 1..0 were previously "Switch to workspace 1..10"; they are now
-- unbound. Move-window bindings (SUPER + SHIFT + N) are unchanged.
for workspace = 1, 10 do
  local key = "code:" .. tostring(workspace + 9)
  hl.unbind("SUPER + " .. key)
  o.bind("ALT + " .. key, "Switch to workspace " .. workspace, hl.dsp.focus({ workspace = tostring(workspace) }))
end

-- SUPER + W closes a tab and SUPER + Q closes the window, mirroring the macOS
-- split between Cmd+W and Cmd+Q.
-- Note: SUPER+W was previously "Close window", which now lives on SUPER+Q.
hl.unbind("SUPER + W")
o.bind("SUPER + W", "Universal close tab", send_shortcut_once("CTRL", "W"))

o.bind("SUPER + Q", "Close window", hl.dsp.window.close())

-- Vim-style window navigation on ALT, replacing SUPER + arrows for focus and
-- SUPER + SHIFT + arrows for swapping.
-- Note: those SUPER + arrow bindings are unbound below. ALT + SHIFT + L also
-- shadows Omarchy's "Copy URL from Web App" Chromium extension shortcut, since
-- Hyprland claims the chord before the browser sees it.
local motions = {
  { key = "H", direction = "l", name = "left" },
  { key = "J", direction = "d", name = "down" },
  { key = "K", direction = "u", name = "up" },
  { key = "L", direction = "r", name = "right" },
}

for _, arrow in ipairs({ "LEFT", "RIGHT", "UP", "DOWN" }) do
  hl.unbind("SUPER + " .. arrow)
  hl.unbind("SUPER + SHIFT + " .. arrow)
end

for _, motion in ipairs(motions) do
  o.bind("ALT + " .. motion.key, "Focus window " .. motion.name, hl.dsp.focus({ direction = motion.direction }))
  o.bind(
    "ALT + SHIFT + " .. motion.key,
    "Swap window " .. motion.name,
    hl.dsp.window.swap({ direction = motion.direction })
  )
end

-- SUPER + 1..9 switch tabs, matching Cmd+1..9 on macOS -- 1-8 pick that tab and
-- 9 jumps to the last one, which is what CTRL + 9 does in Chromium. The SUPER
-- number row was freed when workspace switching moved to ALT above.
for tab = 1, 9 do
  local label = tab < 9 and ("Switch to tab " .. tab) or "Switch to last tab"
  o.bind("SUPER + code:" .. tostring(tab + 9), label, send_shortcut_once("CTRL", tostring(tab)))
end
