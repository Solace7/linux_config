-- Standard awesome library
local gears = require("gears")
local gfs = ("gears.filesystem")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local vicious = require("vicious")
local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
--luarocks loader
pcall(require, "luarocks.loader")
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	--[[    naughty.notify({ preset = naughty.config.presets.critical,
	title = "Oops, there were errors during startup!",
	text = awesome.startup_errors })
	]]--
	awful.spawn("notify-send -u critical " .. awesome.startup_errors)
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function (err)
		-- Make sure we don't go into an endless error loop
		if in_error then return end
		in_error = true

		--[[        naughty.notify({ preset = naughty.config.presets.critical,
		title = "Oops, an error happened!",
		text = tostring(err) })
		]]--
		awful.spawn("notify-send -u critical " .. toString(err))
		in_error = false
	end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_xdg_config_home() .. "awesome/themes/default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "terminator"
editor = "vim"
editor_cmd = terminal .. " -x " .. editor

-- Default modkey.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.floating,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	awful.layout.suit.max,
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
	local instance = nil

	return function ()
		if instance and instance.wibox.visible then
			instance:hide()
			instance = nil
		else
			instance = awful.menu.clients({ theme = { width = 250 } })
		end
	end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
	{ "hotkeys", function() return false, hotkeys_popup.show_help end},
	{ "manual", terminal .. " -e man awesome" },
	{ "edit config", editor_cmd .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{ "quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
  { "open terminal", terminal }
  }
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
--mykeyboardlayout = awful.widget.keyboardlayout()

local function set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	---------------------
	--{{{ WORKSPACES
	---------------------
	-- Each screen has its own tag table.
	local MAIN = awful.tag.find_by_name(root.tags(),tag[1])
	local TWO = awful.tag.find_by_name(root.tags(), tag[2]);
	local THREE = awful.tag.find_by_name(root.tags(),tag[3]);
	local FOUR = awful.tag.find_by_name(root.tags(),tag[4]);
	local GAMES = awful.tag.find_by_name(root.tags(),tag[5]);
	local CODE = awful.tag.find_by_name(root.tags(),tag[6]);
	local SEVEN = awful.tag.find_by_name(root.tags(),tag[7]);
	local EIGHT = awful.tag.find_by_name(root.tags(), tag[8])
	local COMMS = awful.tag.find_by_name(root.tags(),tag[9]);
	local TEN = awful.tag.find_by_name(root.tags(),tag[10]);
	local CREATE = awful.tag.find_by_name(root.tags(),tag[11]);
	awful.tag(
	{ "MAIN", ">>", "3", "4", "GAMES", "CODE", "EXT", "8", "COMMS" , "10", "CREATE" },
	s,
	awful.layout.layouts[1])
	--}}}

	-----------------
	-- {{{ Wibar | Menubar
	-----------------
	-- Create a textclock widget
mytextclock = wibox.widget.textclock("%H:%M %Y-%m-%d" )

--vicious widgets
mpdwidget = wibox.widget.textbox()
vicious.register(mpdwidget, vicious.widgets.mpd,
    function (mpdwidget, args)
			if   args["{state}"] == "Stop" then return ""
		else return '<span color="white">MPD:</span> '..
					args["{Artist}"]..' - '.. args["{Title}"]
		end
    end, 10
)
volwidget = wibox.widget.textbox()
vicious.register(volwidget, vicious.widgets.volume, " $1% ", 60, "Master")
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
	awful.button({ }, 1, function () awful.layout.inc( 1) end),
	awful.button({ }, 3, function () awful.layout.inc(-1) end),
	awful.button({ }, 4, function () awful.layout.inc( 1) end),
	awful.button({ }, 5, function () awful.layout.inc(-1) end)))

	-- Create a wibox for each screen and add it
	local taglist_buttons = gears.table.join(
		awful.button({ }, 1, function(t) t:view_only() end),
		awful.button({ modkey }, 1, function(t)
			if client.focus then
				client.focus:move_to_tag(t)
			end
		end),
		awful.button({ }, 3, awful.tag.viewtoggle),
		awful.button({ modkey }, 3, function(t)
			if client.focus then
				client.focus:toggle_tag(t)
			end
		end),
		awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
		awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
	)

	local tasklist_buttons = gears.table.join(
		awful.button({ }, 1, function (c)
			if c == client.focus then
				c.minimized = true
			else
				-- Without this, the following
				-- :isvisible() makes no sense
				c.minimized = false
				if not c:isvisible() and c.first_tag then
					c.first_tag:view_only()
				end
				-- This will also un-minimize
				-- the client, if needed
				client.focus = c
				c:raise()
			end
		end),
		awful.button({ }, 3, client_menu_toggle_fn()),
		awful.button({ }, 4, function ()
			awful.client.focus.byidx(1)
		end),
		awful.button({ }, 5, function ()
			awful.client.focus.byidx(-1)
		end)
	)

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)
	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.minimizedcurrenttags, tasklist_buttons)

	-- Create the wibox
	s.mywibox = awful.wibar({ position = "top", screen = s, height = 25 })

	-- Add widgets to the wibox
	s.mywibox:setup {
		layout = wibox.layout.align.horizontal,
		expand = "none",
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			s.mytaglist,
		},
		-- Middle widget
		--s.mytasklist,
			mytextclock,
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			--mykeyboardlayout,
			volwidget,
			battery_widget,
			wibox.widget.systray(),
			mytextclock,
			mpdwidget,
			s.mylayoutbox,
		},
	}
end)
-- }}}

------------------------
-- {{{ Mouse bindings
------------------------
root.buttons(gears.table.join(
awful.button({ }, 3, function () mymainmenu:toggle() end),
awful.button({ }, 4, awful.tag.viewnext),
awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

------------------------
-- {{{ Key bindings
------------------------

globalkeys = gears.table.join(
	awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
	{description="show help", group="awesome"}),
	awful.key({ modkey, "Control" }, "Left",   awful.tag.viewprev,
	{description = "view previous", group = "tag"}),
	awful.key({ modkey, "Control" }, "Right",  awful.tag.viewnext,
	{description = "view next", group = "tag"}),
	awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
						{description = "show main menu", group = "awesome"}),
	awful.key({ modkey,           }, "Right",
		function ()
			awful.client.focus.byidx( 1)
		end,
		{description = "focus next by index", group = "client"}
	),
	awful.key({ modkey,           }, "Left",
		function ()
			awful.client.focus.byidx(-1)
		end,
		{description = "focus previous by index", group = "client"}
	),
	awful.key({ modkey, "Shift"   }, "Left", function () awful.client.swap.byidx(  1)    end,
	{description = "swap with next client by index", group = "client"}),
	awful.key({ modkey, "Shift"   }, "Right", function () awful.client.swap.byidx( -1)    end,
	{description = "swap with previous client by index", group = "client"}),
	awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
	{description = "jump to urgent client", group = "client"}),
	awful.key({ modkey,           }, "Tab",
	function ()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end,
	{description = "go back", group = "client"}),

	-- Standard program
	awful.key({ modkey, "Shift" }, "Return", function () awful.spawn(terminal) end,
	{description = "open a terminal", group = "launcher"}),
	awful.key({ modkey, "Shift" }, "r", awesome.restart,
	{description = "reload awesome", group = "awesome"}),
	awful.key({ modkey, "Shift"   }, "e", function () awful.spawn("sh /home/sgreyowl/Documents/Scripts/logout.sh") end,
	{description = "quit awesome", group = "awesome"}),

	awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
	{description = "increase master width factor", group = "layout"}),
	awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
	{description = "decrease master width factor", group = "layout"}),
	awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
	{description = "increase the number of master clients", group = "layout"}),
	awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
	{description = "decrease the number of master clients", group = "layout"}),
	awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
	{description = "increase the number of columns", group = "layout"}),
	awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
	{description = "decrease the number of columns", group = "layout"}),
	awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
	{description = "select next", group = "layout"}),
	awful.key({ modkey, "Control"   }, "space", function () awful.layout.inc(-1)                end,
	{description = "select previous", group = "layout"}),

	-- Prompt
	awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
	{description = "run prompt", group = "launcher"}),
	awful.key({ modkey }, 			     "d", function() awful.spawn("rofi -show") end,
	{description = "rofi prompt", group = "launcher"}),
	awful.key({ modkey }, "x",
	function ()
		awful.prompt.run {
			prompt       = "Run Lua code: ",
			textbox      = awful.screen.focused().mypromptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. "/history_eval"
		}
	end,
	{description = "lua execute prompt", group = "awesome"}),
	-- Menubar
	awful.key({ modkey }, "p", function() menubar.show() end,
	{description = "show the menubar", group = "launcher"}),

	-- Volume Controls
	awful.key({ },"XF86AudioLowerVolume", function() awful.spawn("amixer -q sset Master 5%-") end,
	{description = "Lower volume by 5%", group="system"}),
	awful.key({ },"XF86AudioRaiseVolume", function() awful.spawn("amixer -q sset Master 5%+") end,
	{description = "Raise volume by 5%", group="system"}),
	awful.key({ }, "XF86AudioMute", function() awful.spawn("amixer -q sset Master toggle") end,
	{description = "Mute audio", group="system"})
)

clientkeys = gears.table.join(
	awful.key({ modkey,           }, "f",
		function (c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end,
	{description = "toggle fullscreen", group = "client"}),
	awful.key({ modkey, "Shift"   }, "q",      function (c) c:kill()                         end,
	{description = "close", group = "client"}),
	awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
	{description = "toggle floating", group = "client"}),
	awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
	{description = "toggle keep on top", group = "client"}),
	awful.key({ modkey,           }, "-",
		function (c)
			-- The client currently has the input focus, so it cannot be
			-- minimized, since minimized clients can't have the focus.
			c.minimized = true
		end ,
	{description = "minimize", group = "client"}),
	awful.key({ modkey, "Control" }, "-",
	function ()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			client.focus = c
			c:raise()
		end
	end,
	{description = "restore minimized", group = "client"}),
	awful.key({ modkey,           }, "m",
	function (c)
		c.maximized = not c.maximized
		c:raise()
	end ,
	{description = "(un)maximize", group = "client"}),
	    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key function numbers to tags.
-- This should map on the top row of your keyboard, usually 1 to 10.
for i = 1, 10 do
	globalkeys = gears.table.join(globalkeys,
	-- View tag only.
	awful.key({ modkey }, "#" .. i + 66,
	function ()
		local screen = awful.screen.focused()
		local tag = screen.tags[i]
		if tag then
			tag:view_only()
		end
	end,
	{description = "view tag #"..i, group = "tag"}),
	-- Toggle tag display.
	awful.key({ modkey, "Control" }, "#" .. i + 66,
	function ()
		local screen = awful.screen.focused()
		local tag = screen.tags[i]
		if tag then
			awful.tag.viewtoggle(tag)
		end
	end,
	{description = "toggle tag #" .. i, group = "tag"}),
	-- Move client to tag.
	awful.key({ modkey, "Shift" }, "#" .. i + 66,
	function ()
		if client.focus then
			local tag = client.focus.screen.tags[i]
			if tag then
				client.focus:move_to_tag(tag)
			end
		end
	end,
	{description = "move focused client to tag #"..i, group = "tag"}),
	-- Toggle tag on focused client.
	awful.key({ modkey, "Control", "Shift" }, "#" .. i + 66,
	function ()
		if client.focus then
			local tag = client.focus.screen.tags[i]
			if tag then
				client.focus:toggle_tag(tag)
			end
		end
	end,
	{description = "toggle focused client on tag #" .. i, group = "tag"})
)
end

clientbuttons = gears.table.join(
awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
awful.button({ modkey }, 1, awful.mouse.client.move),
awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-----------------
-- {{{ Rules
-----------------
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{ rule = { },
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			keys = clientkeys,
			buttons = clientbuttons
		}
	},

	-- Floating clients.
	{ rule_any = {
			instance = {
				"DTA",  -- Firefox addon DownThemAll.
				"copyq",  -- Includes session name in class.
			},
			class = {
				"Arandr",
				"Gpick",
				"Steam",
				"Kruler",
				"MessageWin",  -- kalarm.
				"Sxiv",
				"Wpa_gui",
				"pinentry",
				"veromix",
				"xtightvncviewer"
			},
			name = {
				"Event Tester",  -- xev.
			},
			role = {
				"AlarmWindow",  -- Thunderbird's calendar.
				"pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
			},
			type = {
				"dialog"
			}
		},
		properties = { floating = true , awful.placement.centered}
	},

	-- Add titlebars to normal clients and dialogs
	{ rule_any = {type = { "normal", "dialog" }
		}, properties = { titlebars_enabled = true }
	},
}
--}}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and
	not c.size_hints.user_position
	and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
	awful.button({ }, 1, function()
		client.focus = c
		c:raise()
		awful.mouse.client.move(c)
	end),
	awful.button({ }, 3, function()
		client.focus = c
		c:raise()
		awful.mouse.client.resize(c)
	end)
)

awful.titlebar(c) : setup {
	{ -- Left
	awful.titlebar.widget.iconwidget(c),
	buttons = buttons,
	layout  = wibox.layout.fixed.horizontal
},
{ -- Middle
{ -- Title
align  = "center",
widget = awful.titlebar.widget.titlewidget(c)
},
buttons = buttons,
layout  = wibox.layout.flex.horizontal
},
{ -- Right
awful.titlebar.widget.floatingbutton (c),
awful.titlebar.widget.maximizedbutton(c),
awful.titlebar.widget.stickybutton   (c),
awful.titlebar.widget.ontopbutton    (c),
awful.titlebar.widget.closebutton    (c),
layout = wibox.layout.fixed.horizontal()
},
layout = wibox.layout.align.horizontal
}
end)

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter",
-- function(c)
-- 	if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
-- 	and awful.client.focus.filter(c) then
-- 		client.focus = c
-- 	end
-- end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- }}} -- Autostart Applications -- {{{ --
--[[function run_once(cmd, class, tag)
	local callback
	callback = function(c)
		if c.class == calss then
			awful.client.movetotag(tag, c)
			client.remove_signal("manage", callback)
		end
	end
	client.add_signal("manage", callback)
	local findme = cmd
	local firstspace = findme:find(" ")
	if firstspace then
		findme = cmd:sub(0, firstspace-1)
	end
	awful.spawn("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end
--]]
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace-1)
  end
  awful.spawn("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end
--}}}Background Stuff {{{--
awful.spawn("/home/sgreyowl/.config/display_setup.sh")
run_once("/home/sgreyowl/.config/audio_setup.sh")
run_once("compton --config /home/sgreyowl/.config/compton.conf")
run_once("/usr/lib/xfce-polkit/xfce-polkit")
run_once("mpd --no-daemon /home/sgreyowl/.config/mpd/mpd.conf")
run_once("blueman-applet")
run_once("nm-applet")
run_once("redshift-gtk")
run_once("dunst -conf /home/sgreyowl/.config/dunst/dunstrc")
run_once("xfce4-power-manager")
--}}} COMMS Workspace {{{--
commsrun = true
commsStartup = {
	"discord",
	--	"android-messages",
	"yakyak",
}
if commsrun then
	for app = 1, #commsStartup do
		--run_once(commsStartup[app], commsStartup[app], "COMMS")
		run_once(commsStartup[app])
	end
end

-- }}
--}}} GAMES Workspace {{{--
gamesStartup = {
	"steam-native",
}
