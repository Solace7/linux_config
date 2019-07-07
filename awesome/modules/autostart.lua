--Acquire environment
local awful = require("awful")
local gears = require("gears")

local autostart = {}

------------------------------------------
-------}}}Autostart Applications{{{-------
------------------------------------------

function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace-1)
  end
  awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
end

function autostart:run()

    --}}}Background Stuff {{{--
    
    --Run only once
    run_once("compton --config " .. gears.filesystem.get_xdg_config_home() .."/compton.conf")
    run_once(gears.filesystem.get_xdg_config_home() .. "conky/solui.sh")
    run_once("/usr/lib/xfce-polkit/xfce-polkit")
    run_once("xfce4-power-manager")
    run_once("redshift")
    run_once("glava")
    
    --}}} COMMS Workspace {{{--
    commsrun = true
    commsStartup = {
    	"discord",
    }
    if commsrun then
    	for app = 1, #commsStartup do
    		run_once(commsStartup[app])
    	end
        commsrun = false
    end
end

return autostart
