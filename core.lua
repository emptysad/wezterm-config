local vimIntegration = require("vimIntegration")
local wezterm = require("wezterm")
local module = {}

function module.apply_to_config(config)
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

  -- timeout_milliseconds defaults to 1000 and can be omitted
  -- config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
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
  }

  vimIntegration.apply_to_config(config)
end

return module
