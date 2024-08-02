local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local core = require('core')
local status_bar = require('status_bar')
local theme = require('theme')
local vimIntegration = require("vimIntegration")
local keymaps = require("keymaps")
core.apply_to_config(config)
theme.apply_to_config(config)
status_bar.apply_to_config(config)
keymaps.apply_to_config(config)
vimIntegration.apply_to_config(config)


config.color_scheme = 'tokyomight_top'
-- config.hide_tab_bar_if_only_one_tab = true
config.default_workspace = "tdrop"

return config
