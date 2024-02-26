-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

config.font = wezterm.font_with_fallback({
	{ family = "JetBrains Mono", scale = 1.5 },
	{ family = "Symbols Nerd Font", scale = 1.2 },
})

-- Appearance
local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom.background = "#000000"

config.color_schemes = {
  ["OLEDppuccin"] = custom,
}

config.color_scheme = "OLEDppuccin"

config.window_background_opacity = 0.7
config.macos_window_background_blur = 20
config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.hide_mouse_cursor_when_typing = false
config.window_close_confirmation = "NeverPrompt"
config.scrollback_lines = 5000
config.enable_scroll_bar = false
config.window_padding = { left = 10, right = 10, top = 5, bottom = 5 }

-- Dim inactive panes
config.inactive_pane_hsb = {
	brightness = 0.9,
}

-- Keys
config.keys = {
	-- Fix common used keys for cmd instead of ctrl
	{ key = "p", mods = "CMD", action = act.SendKey({ mods = "CTRL", key = "p" }) },
	{ key = "c", mods = "CMD", action = act.SendKey({ mods = "CTRL", key = "c" }) },
	{ key = "d", mods = "CMD", action = act.SendKey({ mods = "CTRL", key = "d" }) },
	{ key = "l", mods = "CMD", action = act.SendKey({ mods = "CTRL", key = "l" }) },

	{ key = "r", mods = "CMD", action = act.SendKey({ mods = "ALT", key = "r" }) },
	{
		key = "t",
		mods = "CMD",
		action = act.Multiple({ act.SendKey({ mods = "CTRL", key = "b" }), act.SendKey({ key = "c" }) }),
	},
	{
		key = "w",
		mods = "CMD",
		action = act.Multiple({ act.SendKey({ mods = "CTRL", key = "b" }), act.SendKey({ key = "x" }) }),
	},
	{
		key = "o",
		mods = "CMD",
		action = act.Multiple({ act.SendKey({ mods = "CTRL", key = "b" }), act.SendKey({ key = "K" }) }),
	},
}
-- I can use the tab navigator (LDR t), but I also want to quickly navigate tabs with index
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CMD",
		action = act.Multiple({ act.SendKey({ mods = "CTRL", key = "b" }), act.SendKey({ key = tostring(i) }) }),
	})
end

return config
