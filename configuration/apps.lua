local filesystem = require('gears.filesystem')
local config_dir = filesystem.get_configuration_dir()
local utils_dir = config_dir .. 'utilities/'

return {
	-- The default applications that we will use in keybindings and widgets
	default = {
		-- Default terminal emulator
		terminal = 'kitty',
		-- Default web browser
		web_browser = 'firefox',
		-- Default text editor
		text_editor = 'geany',
		-- Default file manager
		file_manager = 'thunar',
		-- Default media player
		multimedia = 'celluloid',
		-- Default game, can be a launcher like steam
		game = 'env steam',
		-- Default graphics editor
		graphics = 'gimp',
		-- Default sandbox
		sandbox = 'virt-manager',
		-- Default IDE
		development = 'code',
		-- Default network manager
		network_manager = 'nm-connection-editor',
		-- Default bluetooth manager
		bluetooth_manager = 'blueman-manager',
		-- Default power manager (leaving this here as example)
		power_manager = 'xfce4-power-manager',
		-- Default GUI package manager
		package_manager = 'synaptic',
		-- Default locker
		lock = 'i3lock-fancy',
		-- Default quake terminal
		quake = 'env alacritty --title QuakeTerminal',
		
		-- Default rofi global menu (This is not used in material-awesome as it sometimes froze rofi completely)
		-- kept in the config in-case anyone wants to take a crack at supporting it
		rofi_global = 'env rofi -dpi ' .. screen.primary.dpi .. 
							' -show "Global Search" -modi "Global Search":' .. config_dir .. 
							'/configuration/rofi/global/rofi-spotlight.sh' .. 
							' -theme ' .. config_dir ..
							'/configuration/rofi/global/rofi.rasi',
		
		-- Default app menu
		rofi_appmenu = 'env rofi -dpi ' .. screen.primary.dpi ..
							' -show drun -theme ' .. config_dir ..
							'/configuration/rofi/appmenu/rofi.rasi -run-command "/bin/bash -c -i \'shopt -s expand_aliases; {cmd}\'"',

		-- You can add more default applications here
	},

	-- List of apps to start once on start-up
	run_on_start_up = {
		-- Compositor
		'picom -b --experimental-backends --dbus --config ' ..
		config_dir .. '/configuration/picom.conf',

		-- network applet for network connections
		'nm-applet --indicator',
		
		-- Blueman applet
		'blueman-applet',
		
		-- ibus keyboard daemon for keyboard management and emoji typing
		'ibus-daemon --xim --daemonize',

		-- scream audio sink for windows10 VM audio
    	'scream-start',

		-- turn on numlock
    	'numlockx on',

		-- start kdeconnect-indicator (script to handle awesome restarts)
		utils_dir .. 'kdeconnect',

		-- Music server
		--'mpd',

		-- Polkit and keyring (uncomment the one you use)
		'/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 & ' ..
		--'/usr/bin/lxqt-policykit-agent & ' ..
		--'/usr/lib/x86_64-linux-gnu/libexec/polkit-kde-authentication-agent-1 & ' ..
		
		-- use the gnome keyring with the polkit from the line above (easiest one to integrate)
		'eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)',
		
		-- Load X colors
		'xrdb $HOME/.Xresources',
		
		-- Audio equalizer
		--'pulseeffects --gapplication-service',
		
		-- Lockscreen timer
		[[
		xidlehook --not-when-fullscreen --not-when-audio --timer 600 \
		"i3lock-fancy" ""
		]],

		-- Set brightness to 50% on LVDS output because my laptop battery is bad
		utils_dir .. 'laptop-brightness set 50',
		
		-- Spawn "dirty" apps that can linger between sessions
		-- It is suggested you copy the contents of awspawn into ~/.config/awesomestart
		-- then remove the "$HOME/.config/awesomestart" line from the APPS array
		'~/.config/awesome/configuration/awspawn'

		-- You can add more start-up applications here
	},

	-- List of binaries/shell scripts that will execute for a certain task
	utils = {
		-- Hikari's screenshot utilities (requires ksnip to be installed)
		screenshot = utils_dir .. 'screenshot -m -s',
		region_screenshot = utils_dir .. 'screenshot -r -s',
		delayed_screenshot = utils_dir .. 'screenshot -d 10 -r',
		ss_and_edit_screenshot = utils_dir .. 'screenshot -r',

		-- Other screenshot utilities using maim
		-- Fullscreen screenshot
		full_screenshot = utils_dir .. 'snap full',
		-- Area screenshot
		area_screenshot = utils_dir .. 'snap area',

		-- Emoji keyboard toggle script
		-- (edit the script inside ~/.config/awesome/utilities to use your keyboard layout settings!)
		-- Requires: ibus and uniemoji to be installed
		emoji_toggle = utils_dir .. 'emoji-toggle',

		-- Update profile picture
		update_profile  = utils_dir .. 'profile-image'
	}
}
