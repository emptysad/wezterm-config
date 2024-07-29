local wezterm = require("wezterm")
local module = {}

function module.apply_to_config(config)
	wezterm.on("update-right-status", function(window, pane)
		local date = wezterm.strftime("%H:%M")
		local bat = ""
		local bat_color = ""
		local bat_weight = "Normal"
		for _, b in ipairs(wezterm.battery_info()) do
			bat = b.state_of_charge * 100
			if b.state == "Charging" then
				bat_color = "#fff133"
				bat_weight = "Bold"
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
			end
		end

		local success, stdoutCPU, stderr = wezterm.run_child_process({ "/home/emptysad/.config/wezterm/getCPUusage.sh" })
		local success, stdoutMEM, stderr = wezterm.run_child_process({ "/home/emptysad/.config/wezterm/getMEMusage.sh" })
		window:set_right_status(wezterm.format({
			{ Attribute = { Intensity = "Normal"} },
			{ Foreground = { Color = "gray" } },
			{ Text = string.format(" %.1f%%  ", stdoutMEM)},

			{ Attribute = { Intensity = "Normal"} },
			{ Foreground = { Color = "gray" } },
			{ Text = string.format(" %.1f%%  ", stdoutCPU)},

			{ Attribute = { Intensity = bat_weight } },
			{ Foreground = { Color = bat_color } },
			{ Text = string.format("%.0f%%", bat) },

			{ Attribute = { Intensity = "Normal" } },
			{ Foreground = { Color = "white" } },
			{ Text = "  " .. date .. " " },
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
