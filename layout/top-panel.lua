local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')
local icons = require('theme.icons')
local dpi = beautiful.xresources.apply_dpi
local clickable_container = require('widget.clickable-container')
local task_list = require('widget.task-list')

local top_panel = function(s, offset)

	local offsetx = 0
	if offset == true then
		offsetx = dpi(45)
	end

	local panel = wibox
	{
		ontop = true,
		screen = s,
		type = 'dock',
		height = dpi(45),
		width = s.geometry.width - offsetx,
		x = s.geometry.x + offsetx,
		y = s.geometry.y,
		stretch = false,
		bg = beautiful.background,
		fg = beautiful.fg_normal
	}

	panel:struts
	{
		top = dpi(45)
	}

	panel:connect_signal(
		'mouse::enter',
		function() 
			local w = mouse.current_wibox
			if w then
				w.cursor = 'left_ptr'
			end
		end
	)

	s.systray = wibox.widget {
		visible = true,
		base_size = dpi(20),
		horizontal = true,
		screen = 'primary',
		widget = wibox.widget.systray
	}

	local clock 			= require('widget.clock')(s)
	local layout_box 		= require('widget.layoutbox')(s)
	local add_button 		= require('widget.open-default-app')(s)
	s.tray_toggler  		= require('widget.tray-toggle')
	s.updater 				= require('widget.package-updater')()
	s.screen_rec 			= require('widget.screen-recorder')()
	s.mpd       			= require('widget.mpd')()
	s.bluetooth   			= require('widget.bluetooth')()
	s.battery     			= require('widget.battery')()
	s.network       		= require('widget.network')()
	s.info_center_toggle	= require('widget.info-center-toggle')()

    local battery_avaiable = true
    local get_battery_avaiable = function()
        awful.spawn.easy_async_with_shell(
            'upower -i $(upower -e | grep BAT)',
            function(stdout)
                if stdout == nil or stdout == '' then
                    panel : setup {
                        layout = wibox.layout.align.horizontal,
                        expand = 'none',
                        require('layout.left-panel.action-bar')(s, panel, dpi(45)),
                        {
                            layout = wibox.layout.fixed.horizontal,
                            task_list(s),
                            add_button
                        },
                        nil, 
                        {
                            layout = wibox.layout.fixed.horizontal,
                            spacing = dpi(5),
                            {
                                s.systray,
                                left = dpi(5),
                                right = dpi(5),
                                top = dpi(12),
                                bottom = dpi(12),
                                widget = wibox.container.margin
                            },
                            s.tray_toggler,
                            --s.updater,
                            --s.screen_rec,
                            --s.mpd,
                            --s.network,
                            --s.bluetooth,
                            clock,
                            layout_box,
                            s.info_center_toggle
                        }
                    }
                else
                    panel : setup {
                        layout = wibox.layout.align.horizontal,
                        expand = 'none',
                        require('layout.left-panel.action-bar')(s, panel, dpi(45)),
                        {
                            layout = wibox.layout.fixed.horizontal,
                            task_list(s),
                            add_button
                        },
                        nil, 
                        {
                            layout = wibox.layout.fixed.horizontal,
                            spacing = dpi(5),
                            {
                                s.systray,
                                left = dpi(5),
                                right = dpi(5),
                                top = dpi(12),
                                bottom = dpi(12),
                                widget = wibox.container.margin
                            },
                            s.tray_toggler,
                            --s.updater,
                            --s.screen_rec,
                            --s.mpd,
                            --s.network,
                            --s.bluetooth,
                            s.battery,
                            clock,
                            layout_box,
                            s.info_center_toggle
                        }
                    }
                end
            end
        )
    end
    get_battery_avaiable()

	return panel
end


return top_panel
