#!/bin/bash
echo -e `date` "\n" >> /var/log/audiosetuplog

echo "Starting JACK" >> /var/log/audiosetuplog
jack_control start | tee -a /var/log/audiosetuplog
jack_control ds alsa | tee -a /var/log/audiosetuplog
jack_control dps device hw:PCH | tee -a /var/log/audiosetuplog
jack_control dps rate 44100 | tee -a /var/log/audiosetuplog
jack_control dps nperiods 3 | tee -a /var/log/audiosetuplog
jack_control dps period 1024 | tee -a /var/log/audiosetuplog
sleep 10

echo -e "Connecting a2j MIDI \n" >> /var/log/audiosetuplog
a2jmidid -ue & >> /var/log/audiosetuplog
sleep 10
pactl set-default-sink jack_out
echo "jack_out set as default sink" >> /var/log/audiosetuplog
pactl set-default-source jack_in
echo "jack_in set as default source" >> /var/log/audiosetuplog
alsactl restore
notify-send "JACK Audio Connection Kit is connected and set for MIDI"
echo "Jack Setup Complete" >> /var/log/audiosetuplog
echo "Peripheral Check" >> /var/log/audiosetuplog
if [ -d "/proc/asound/Mic" ]; then
		echo "Samson Meteor Mic is Connected" >> /var/log/audiosetuplog
		samson_mic
		samson_speaker
fi

#echo -e "Starting Cadence \n" >> /var/log/audiosetuplog
#cadence --minimized &

echo -e "Done \n" >> /var/log/audiosetuplog
echo `date` >> /var/log/audiosetuplog

if [[ $(wc --lines /var/log/audiosetuplog) > 32 ]]; then
    rm /var/log/audiosetuplog
    touch /var/log/audiosetuplog
    echo "Audio Setup Completed. New log file created" >> /var/log/audiosetuplog
    echo `date` >> /var/log/audiosetuplog
fi

exit 1
