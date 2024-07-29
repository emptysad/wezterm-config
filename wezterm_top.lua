local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local core = require('core')
local theme = require('theme')
core.apply_to_config(config)
theme.apply_to_config(config)


config.color_scheme = 'tokyomight_top'
config.hide_tab_bar_if_only_one_tab = true

return config
