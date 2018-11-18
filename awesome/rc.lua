-- Standard awesome library
local gears = require("gears")
local gfs = ("gears.filesystem")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Extra plugins!
local lain = require("lain")
local timestamp = require("redflat.timestamp")

----------------------------------{{{ERROR HANDLING}}}----------------------------------

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
		awful.spawn("notify-send -u critical " .. awesome.startup_errors)
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

		awful.spawn("notify-send -u critical " .. toString(err))
			in_error = false
	end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_xdg_config_home() .. "awesome/themes/gruvbox/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "terminator"
editor = "vim"
editor_cmd = terminal .. " -x " .. editor
scripts_folder = "/home/sgreyowl/.config/scripts/"

-- Default modkey.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.magnifier,
    awful.layout.suit.max,

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

--Monitor script
 awful.spawn("/home/sgreyowl/.config/scripts/display_setup.sh")

------------------------
-------{{{MENU}}}-------
------------------------

-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({
    items = {
        { "awesome", myawesomemenu, beautiful.awesome_icon },
        { "open terminal", terminal }
    }
})

-----------------------
-------{{WIBAR}}-------
-----------------------

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
mytextclock = wibox.widget.textclock("%H:%M:%S § %Y-%m-%d",1)

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
                                          end))

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
----------------------------
-------{{WORKSPACES}}-------
----------------------------

    -- Each screen has its own tag table.
awful.tag(
{
    "MAIN",
    "SECONDARY",
    "TERTIARY",
    "QUATERNARY",
    "GAMES",
    "DEVELOP",
    "EXT",
    "COMMS",
    "NONARY" ,
    "DENARY",
}, s, awful.layout.layouts[1])

--------------------------------
-------{{END WORKSPACES}}-------
--------------------------------
    -- Wallpaper
    set_wallpaper(s)

------------------------------
---------{{TITLEBAR}}---------
------------------------------
local barheight = 24
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.noempty, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    --Systemtray widget
    local systemtray = wibox.widget.systray()

    --Volume widget
    local volume = lain.widget.alsa({
        settings = function()
            widget:set_markup(" " .. volume_now.level .. " ")
        end
    })
 
    local volumebar = lain.widget.alsabar()

    --Change Volume on Scrollwheel up/down
    volume.widget:buttons(awful.util.table.join(
        awful.button({ }, 4, function()  
            awful.spawn("amixer -q sset Master 5%+") --scroll up
            volume.update()
        end),
        awful.button({ }, 5, function()  
            awful.spawn("amixer -q sset Master 5%-") --scroll down
            volume.update()
        end)
    ))

    -- Create the wibox
    s.topbar = awful.wibar({ position = "top", screen = s, height=barheight })

    -- Add widgets to the wibox
    s.topbar:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- Left Widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
        },
            -- Middle Widgets
            mytextclock,
        { -- Right Widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            s.mylayoutbox,
        },
    }

    -- create second wibar
    s.bottombar = awful.wibar({ position = "bottom", screen = s, height=barheight })
    s.bottombar:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        {-- Left Widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytasklist,
        },
        --Middle Wdigets
            nil, --Just a separator
        {-- Right Widgets
            layout = wibox.layout.fixed.horizontal,
            volume,
            systemtray,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

--------------------------
-------{{KEYBINDS}}-------
--------------------------

globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "w", function () mymainmenu:toggle() end,
              {description = "toggle main menu visibility", group = "awesome"}),

    awful.key({ modkey, "Control" }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey, "Control" }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    --Switching Windows
    awful.key({ modkey,           }, "Right",
        function ()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus window right", group = "client"}
    ),
    awful.key({ modkey,           }, "Left",
        function ()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus window left", group = "client"}
    ),
    awful.key({ modkey,           }, "Down",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus window below", group = "client"}
    ),
    awful.key({ modkey,           }, "Up",
        function()
        if client.focus then client.focus:raise() end
            awful.client.focus.global_bydirection("up")
        end,
        {description = "focus window above", group = "client"}
    ),

    --Moving Windows
    awful.key({ modkey, "Shift"   }, "Left",
    function ()
        awful.client.swap.global_bydirection("left")
    end,
              {description = "swap with client to the left", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Right",
    function ()
        awful.client.swap.global_bydirection("right")
    end,
              {description = "swap with client to the right", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Down",
    function ()
        awful.client.swap.global_bydirection("down")
    end,
              {description = "swap with client below", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Up",
    function ()
        awful.client.swap.global_bydirection("up")
    end,
              {description = "swap with client above", group = "client"}),

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

    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_bydirection("left") end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_bydirection("right") end,
              {description = "focus the previous screen", group = "screen"}),

    -- Standard program
    awful.key({ modkey, "Shift" }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "e", function () awful.spawn("sh " .. scripts_folder .. "logout.sh") end,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey, "Control"   }, "l", function () awful.spawn("sh betterlockscreen -l blur -t 'S_Greyowl is Away'") end,
              {description = "lock awesome", group = "awesome"}),

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
	awful.key({modkey}, 			"d", function() awful.spawn("rofi -show") end,
			  {description = "rofi prompt", group = "launcher"}),

    --{{{Volume Control
    awful.key({},"XF86AudioLowerVolume",
        function()
            awful.spawn("amixer -q sset Master 5%-")
            volume.update()
        end,
    	{description = "Lower volume by 5%", group="client"}),
    awful.key({},"XF86AudioRaiseVolume",
        function()
            awful.spawn("amixer -q sset Master 5%+")
            volume.update()
        end,
    	{description = "Raise volume by 5%", group="client"}),
    awful.key({}, "XF86AudioMute",
        function()
            awful.spawn("amixer -q sset Master toggle")
            volume.update()
        end,
    	{description = "Mute audio", group="client"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "q",      function (c) c:kill()                         end,
              {description = "close focused client", group = "client"}),
    awful.key({ modkey, "Shift" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),

    awful.key({ modkey,           }, "-",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            local l = awful.layout.getname(awful.layout.get(awful.screen.focused()))
            if(l == "max") then
                awful.layout.set(awful.layout.suit.tile)
            else
                awful.layout.set(awful.layout.suit.max)
            end
            
            --c.maximized = not c.maximized
            --c:raise()
        end ,
        {description = "(un)maximize", group = "tag"}),
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


----------------------------------{{{WORKSPACE KEYBINDS}}}----------------------------------

-- Bind all key function numbers to tags.
local FKEY = 66;
for i = 1, #root.tags() do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + FKEY,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + FKEY,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + FKEY,
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
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + FKEY,
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

----------------------------------{{{Mouse Buttons}}}----------------------------------
clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize)
)

-- Set keys
root.keys(globalkeys)
----------------------------------{{{RULES}}}----------------------------------
local rules = require("modules.rules")
rules:enable()
----------------------------------{{{SIGNALS}}}----------------------------------
local signals = require("modules.signals")
signals:listen()
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

        awful.titlebar(c):setup {
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
----------------------------------{{AUTOSTART}}----------------------------------
local autostart = require("modules.autostart")
if timestamp.is_startup() then
    autostart.run()
end
