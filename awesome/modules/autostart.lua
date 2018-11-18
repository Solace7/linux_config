--Acquire environment
local awful = require("awful")

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

function autostart.run()    
    --}}}Background Stuff {{{--
    
    --Run only once
    run_once("compton --config /home/sgreyowl/.config/compton.conf")
    run_once("mpd --no-daemon /home/sgreyowl/.config/mpd/mpd.conf")
    run_once("dunst -conf /home/sgreyowl/.config/dunst/dunstrc")
    run_once("/home/sgreyowl/.config/scripts/audio_setup.sh")
    run_once("/usr/lib/xfce-polkit/xfce-polkit")
    run_once("xfce4-power-manager")
    run_once("blueman-applet")
    run_once("nm-applet")
    run_once("pamac-tray")
    
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
