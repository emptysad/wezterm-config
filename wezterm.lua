local wezterm = require 'wezterm'
local mux = wezterm.mux
local config = wezterm.config_builder()

local core = require('core')
local status_bar = require('status_bar')
local theme = require('theme')
local keymaps = require("keymaps")
local vimIntegration = require("vimIntegration")

core.apply_to_config(config)
status_bar.apply_to_config(config)
theme.apply_to_config(config)
keymaps.apply_to_config(config)
vimIntegration.apply_to_config(config)


--StartUp
wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
  wezterm.sleep_ms(10)
  local panel = pane:split {direction = 'Left', size = 46}
  panel:split {direction = 'Top', size = 8, args = {"spotify_player"}}
end)

config.color_scheme = 'tokyomight_fullscreen'
config.default_workspace = "fullscreen"

return config
