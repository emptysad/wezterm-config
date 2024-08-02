local wezterm = require("wezterm")
local module = {}

function module.apply_to_config(config)
	config.keys = {
		{
			key = "\\",
			mods = "CMD",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "-",
			mods = "CMD",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "q",
			mods = "CMD",
			action = wezterm.action.CloseCurrentPane({ confirm = true }),
		},
		{
			key = "n",
			mods = "CMD",
			action = wezterm.action.SpawnTab("CurrentPaneDomain"),
		},
		{
			key = "h",
			mods = "CMD",
			action = wezterm.action.ActivateTabRelative(-1),
		},
		{
			key = "l",
			mods = "CMD",
			action = wezterm.action.ActivateTabRelative(1),
		},
		{
			key = "z",
			mods = "CMD",
			action = wezterm.action.TogglePaneZoomState,
		},
		{
			key = "l",
			mods = "ALT",
			action = wezterm.action.ShowLauncher,
		},
	}
end

return module
