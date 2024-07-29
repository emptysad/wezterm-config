local wezterm = require("wezterm")
local module = {}

local tokyomight_top = wezterm.color.get_builtin_schemes()["Tokyo Night"]
tokyomight_top.background = "#001214"
tokyomight_top.tab_bar.background= "black"

local tokyomight_fullscreen = wezterm.color.get_builtin_schemes()["Tokyo Night"]
tokyomight_fullscreen.background = "black"
tokyomight_fullscreen.tab_bar.background= "#0d0d0d"
tokyomight_fullscreen.tab_bar.active_tab.fg_color= "#f7c06e"
tokyomight_fullscreen.tab_bar.active_tab.bg_color= "black"
tokyomight_fullscreen.tab_bar.active_tab.intensity = "Bold"
tokyomight_fullscreen.tab_bar.inactive_tab.bg_color= "#0d0d0d"

function module.apply_to_config(config)
	config.color_schemes = {
		["tokyomight_top"] = tokyomight_top,
		["tokyomight_fullscreen"] = tokyomight_fullscreen,
	}
end
return module
