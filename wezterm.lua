local wezterm = require 'wezterm'
local mux = wezterm.mux
local config = wezterm.config_builder()

local core = require('core')
local status_bar = require('status_bar')
local theme = require('theme')

core.apply_to_config(config)
status_bar.apply_to_config(config)
theme.apply_to_config(config)


--StartUp
wezterm.on('gui-startup', function(cmd)
  local _, _, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

config.color_scheme = 'tokyomight_fullscreen'

return config
