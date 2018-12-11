
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
      "xtightvncviewer",
      "file_progress"
    },
    type = {
        "dialog",
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
        "discord",
        "Android Messages"
    }
}

rules.CREATE = {
    class = {
        "gimp-2.10",
        "Inkscape",
        "Natron",
        "Blender",
        "Krita",
        "REAPER"
    }
}

rules.DEVELOP = {
    class = {
        "jetbrains-idea",
        "jetbrains-clion",
        "jetbrains-toolbox",
        "jetbrains-studio"
    }
}

rules.GAMES = {
    class = {
        "Steam",
        "MultiMC",
        "Lutris"
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
            properties = { floating = true, ontop = true, placement = awful.placement.centered} 
        },
        {
            rule_any = rules.COMMS,
            properties = { tag = "COMMS" }
        },
        {
            rule_any = rules.CREATE,
            properties = { tag = "CREATE" }
        },
        {
            rule_any = rules.DEVELOP,
            properties = { tag = "DEVELOP" }
        },
        {
            rule_any = rules.GAMES,
            properties = { tag = "GAMES" }
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
