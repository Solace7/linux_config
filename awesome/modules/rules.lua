
--Acquire environment
local awful = require("awful")
local beautiful = require("beautiful")

local rules = {}

-----------------------------------------------
-------{{Application Window Properites}}-------
-----------------------------------------------
-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).

rules.all_clients = {
    border_width = beautiful.border_width,
    border_color = beautiful.border_normal,
    keys = clientkeys,
    buttons = clientbuttons,
    titlebars_enables = true,
    screen = awful.screen.preferred,
    --placement = awful.placement.no_overlap+awful.placement.no_offscreen
    --focus = awful.client.focus.filter,
    --raise = true,
}

rules.floating_clients = {
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
    }
}

rules.COMMS = {
    class = {
        "discord"
    }
}

function rules:enable()
    self.rules = {
        {
            rule = {},
            properties = self.all_clients
        },
        {
            rule_any = self.floating_clients,
            properties = { floating = true, ontop = true, placement = centered} 
        },
        {
            rule_any = rules.COMMS,
            properties = { tag = "COMMS" }
        },
        {
            rule_any = { type = { "normal", "dialog" }},
            properties = { titlebars_enabled = true }
        }
    }

-- Set rules
    awful.rules.rules = rules.rules
end

return rules
