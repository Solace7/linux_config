#!/bin/bash
if [ -f "/var/log/audiosetuplog" ]; then
    echo `date` >> /var/log/audiosetuplog
    echo ""
fi

echo "Starting JACK" >> /var/log/audiosetuplog
jack_control start
jack_control ds alsa
jack_control dps device hw:PCH
jack_control dps rate 44100
jack_control dps nperiods 3
#Buffer
jack_control dps period 1024
sleep 10
echo "Connecting a2j MIDI" >> /var/log/audiosetuplog
a2jmidid -ue &
sleep 10
pactl set-default-sink jack_out
pactl set-default-source jack_in
alsactl restore
notify-send "JACK Audio Connection Kit is connected and set for MIDI"
echo "Jack Setup Complete" >> /var/log/audiosetuplog
echo "Peripheral Check" >> /var/log/audiosetuplog
if [ -d "/proc/asound/Mic" ]; then
		echo "Samson Meteor Mic is Connected" >> /var/log/audiosetuplog
		samson_mic
		samson_speaker
fi

echo "Starting Cadence" >> /var/log/audiosetuplog
cadence --minimized &

echo "Done" >> /var/log/audiosetuplog

if [ wc --lines /var/log/audiosetuplog > 32]; then
    rm /var/log/audiosetuplog
    touch /var/log/audiosetuplog
fi

exit 1
