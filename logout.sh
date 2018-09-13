#!/bin/sh
ESCAPE=$(zenity --width=300 --height=200 --list --text="Select exit action" --title="Logout" --column "I want to..." "shutdown" "reboot" "lock" "suspend" "exit")
	case "$ESCAPE" in
		"shutdown")
			systemctl poweroff;;
		"reboot")
			systemctl reboot;;
		"suspend")
			systemctl suspend;;
		"lock")
			dm-tool lock;;
		"exit")
            if [ $DESKTOP_SESSION == "i3" ]; then
                i3-msg exit
            fi
            ;;
           *)
            notify-send "Not yet...";;
    esac
