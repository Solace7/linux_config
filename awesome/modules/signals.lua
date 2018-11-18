--Acquire environment
local awful = require("awful")
local beautiful = require("beautiful")

local signals = {}

local function do_sloppy_focus(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier and awful.client.focus.filter(c) then
        client.focus = c
    end
end

function signals:listen()
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
    --move clients from disconnected screen to connected screen
    tag.connect_signal("request::screen", function(t)
        awful.spawn("notify-send -u critical 'Screen Disconnected' ")
        for s in screen do
            if (s ~= t.screen) then
                local t2 = awful.tag.find_by_name(s,t.name)
                if(t2) then
                    t:swap(t2)
                else
                    t.screen = s
                end
                return
            end
        end 
    end)
    
end

return signals
