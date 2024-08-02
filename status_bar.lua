local wezterm = require("wezterm")
local module = {}

local function textAlign(str, len, align)
  local freeSpace = len - str:len()
  if freeSpace < 0 then
    return "Err: " .. str:len() .. "<" .. len
  else
    if align == "left" then
      return str .. string.rep(" ", freeSpace)
    elseif align == "center" then
      return string.rep(" ", (freeSpace // 2)) .. str .. string.rep(" ", (freeSpace // 2))
    elseif align == "center+" then
      return string.rep(" ", (freeSpace // 2)) .. str .. string.rep(" ", (freeSpace - freeSpace // 2))
    elseif align == "+center" then
      return string.rep(" ", (freeSpace - freeSpace // 2)) .. str .. string.rep(" ", (freeSpace // 2))
    elseif align == "right" then
      return string.rep(" ", freeSpace) .. str
    end
  end
end

function module.apply_to_config(config)
	wezterm.on("update-right-status", function(window, pane)
		local date = wezterm.strftime("%H:%M")
		local bat = ""
		local bat_color = ""
		local bat_weight = "Normal"
		for _, b in ipairs(wezterm.battery_info()) do
			bat = b.state_of_charge * 100
			if b.state == "Charging" then
				bat_color = "#aa98ec"
				bat_weight = "Bold"
        bat = string.format("+%.0f%%", bat)
			elseif b.state == "Discharging" then
				if bat >= 70 then
					bat_color = "#5cff33"
				elseif bat >= 40 then
					bat_color = "#b4ff33"
				elseif bat >= 25 then
					bat_color = "#ffc233"
				elseif bat >= 0 then
					bat_color = "#ff3333"
				end
				bat_weight = "Normal"
        bat = string.format("%.0f%%", bat)
			end
		end

		local success, stdoutCPU, stderr = wezterm.run_child_process({ "/home/emptysad/.config/wezterm/getCPUusage.sh" })
		local success, stdoutMEM, stderr = wezterm.run_child_process({ "/home/emptysad/.config/wezterm/getMEMusage.sh" })
		window:set_right_status(wezterm.format({
			{ Attribute = { Intensity = "Normal"} },
			{ Foreground = { Color = "gray" } },
			{ Text = textAlign(string.format(" %s  ", window:active_workspace()), 20, "right")},

			{ Attribute = { Intensity = "Normal"} },
			{ Foreground = { Color = "gray" } },
			{ Text = textAlign(string.format(" %.1f%%", stdoutMEM), 11, "left")},

			{ Attribute = { Intensity = "Normal"} },
			{ Foreground = { Color = "gray" } },
			{ Text = textAlign(string.format(" %.1f%%", stdoutCPU), 11, "left")},

			{ Attribute = { Intensity = "Normal"} },
			{ Foreground = { Color = "#343434" } },
			{ Text = textAlign("│", 3, "right")},

			{ Attribute = { Intensity = bat_weight } },
			{ Foreground = { Color = bat_color } },
			{ Text = textAlign(bat, 7, "center+")},

			{ Attribute = { Intensity = "Normal" } },
			{ Foreground = { Color = "white" } },
			{ Text = date .. " " },
		}))
	end)

	config.show_tab_index_in_tab_bar = false
	-- This function returns the suggested title for a tab.
	-- It prefers the title that was set via `tab:set_title()`
	-- or `wezterm cli set-tab-title`, but falls back to the
	-- title of the active pane in that tab.
	local function tab_title(tab_info)
		local title = tab_info.tab_title
		-- if the tab title is explicitly set, take that
		if title and #title > 0 then
			return title
		end
		-- Otherwise, use the title from the active pane
		-- in that tab
		return tab_info.active_pane.title
	end

	wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
		local title = tab_title(tab)
		if tab.is_active then
			return {
				{ Text = " " .. title .. " " },
			}
		end
		if tab.is_active == false then
			return {
				{ Text = " " .. title .. " " },
			}
		end
		return title
	end)
end

return module
