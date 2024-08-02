local wezterm = require("wezterm")
local module = {}

function module.apply_to_config(config)
	-- config.enable_kitty_graphics = true
	config.text_background_opacity = 0.75
	config.window_background_opacity = 0.85
	config.font = wezterm.font("RobotoMono Nerd Font")
	config.font_size = 15
	config.enable_tab_bar = true
	config.tab_bar_at_bottom = true
	config.use_fancy_tab_bar = false
	config.window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	}
	config.cell_width = 1
	config.window_decorations = "NONE"
	config.use_dead_keys = false
	config.show_new_tab_button_in_tab_bar = false
end

return module
