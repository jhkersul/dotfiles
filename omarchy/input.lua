-- Keep only your personal input overrides here. Uncommented settings below
-- replace Omarchy's defaults.

-- Keyboard layout and options.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
-- hl.config({
--   input = {
--     -- Use multiple keyboard layouts and switch between them with Left Alt + Right Alt.
--     kb_layout = "us,dk,eu",
--     kb_options = "compose:caps,shift:both_capslock_cancel,grp:alts_toggle",
--
--     -- Use a specific keyboard variant if needed (e.g. intl for international keyboards).
--     kb_variant = "intl",
--
--     -- Change speed of keyboard repeat.
--     repeat_rate = 40,
--     repeat_delay = 250,
--
--     -- Start with numlock on by default.
--     numlock_by_default = true,
--
--     -- Increase sensitivity for mouse/trackpad (default: 0).
--     sensitivity = 0.35,
--
--     -- Turn off mouse acceleration (default: adaptive).
--     accel_profile = "flat",
--
--     touchpad = {
--       -- Use natural (inverse) scrolling.
--       natural_scroll = true,
--
--       -- Use two-finger clicks for right-click instead of lower-right corner.
--       clickfinger_behavior = true,
--
--       -- Control the speed of your scrolling.
--       scroll_factor = 0.4,
--
--       -- Enable the touchpad while typing.
--       disable_while_typing = false,
--
--       -- Left-click-and-drag with three fingers.
--       drag_3fg = 1,
--     },
--   },
-- })

-- App-specific touchpad scroll speeds.
-- o.window("(Alacritty|kitty|foot)", { scroll_touchpad = 1.5 })
-- o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })

-- Enable touchpad gestures for changing workspaces.
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
-- hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Enable touchpad gestures for moving focus (helpful on scrolling layout).
-- hl.gesture({ fingers = 3, direction = "left", action = function() hl.dispatch(hl.dsp.focus({ direction = "l" })) end })
-- hl.gesture({ fingers = 3, direction = "right", action = function() hl.dispatch(hl.dsp.focus({ direction = "r" })) end })

-- Swap Escape and Caps Lock. Replaces Omarchy's default `compose:caps`
-- (Caps as Compose key) and `shift:both_capslock_cancel` (Caps Lock on
-- both Shifts) -- Caps Lock now lives on the physical Escape key.
--
-- US International with dead keys, for typing PT-BR on US hardware:
--   ' + a -> a-acute      ~ + a -> a-tilde      ^ + a -> a-circumflex
--   ` + a -> a-grave      " + u -> u-diaeresis
--   AltGr + ,             -> c-cedilla    ' + c -> c-cedilla (via ~/.XCompose)
-- The dead keys emit their literal character when followed by Space, or
-- immediately via AltGr (AltGr+' = ', AltGr+Shift+' = ", AltGr+` = `,
-- AltGr+Shift+` = ~, AltGr+Shift+6 = ^).
--
-- Note: this variant makes Right Alt the AltGr (level 3) modifier, so it no
-- longer triggers the ALT window-manager bindings -- use Left Alt for those.
hl.config({
  input = {
    kb_variant = "intl",
    kb_options = "caps:swapescape",
  },
})
