#!/bin/bash
echo "Starting JACK" >> /var/log/audiosetuplog
jack_control start
jack_control ds alsa
jack_control dps device hw:PCH
jack_control dps rate 44100
jack_control dps nperiods 3
#Buffer
jack_control dps period 1024
sleep 10
echo "Connecting a2j MIDI"
a2jmidid -ue &
sleep 10
cadence --minimized &
pactl set-default-sink jack_out
notify-send "JACK Audio Connection Kit is connected and set for MIDI"

echo "Peripheral Check"
if [ -d "/proc/asound/Mic" ]; then
		echo "Samson Meteor Mic is Connected"
		samson_mic
		samson_speaker
fi
