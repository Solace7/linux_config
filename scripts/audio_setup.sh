#!/bin/bash

LOG=$HOME/.log/audiosetuplog
CONNECTIONS=$HOME/Documents/Projects/Audio/ajsnapshots/default

if [ -f $LOG ]; then
  echo -e `date` "\n" >> $LOG
else
  touch $LOG
  echo -e `date` "\n" >> $LOG
fi

if [[ $(wc --lines $LOG) > 1024 ]]; then
    rm $LOG
    touch $LOG
    echo "Audio Setup Completed. New log file created" >> $LOG
    echo `date` >> $LOG
fi

#alsactl store
echo "Starting JACK" >> $LOG

jack_control ds alsa | tee -a $LOG

#Audio Interface
if [ -d "/proc/asound/CODEC" ]; then
    echo "Audio Interface Detected" >> $LOG
    jack_control dps device hw:CODEC | tee -a $LOG
    #laptop ports to jack patchbay
#    laptop-ports & >> $LOG
    #Separate outputs to connect via JACK
    #um2_ports & >> $LOG
else
    #Internal Audio
    echo "Using Internal Audio Card" >> $LOG
    jack_control dps device hw:PCH | tee -a $LOG
fi

jack_control dps rate 48000 | tee -a $LOG
jack_control eps realtime true
jack_control dps nperiods 3 | tee -a $LOG
jack_control dps period 512 | tee -a $LOG

jack_control start | tee -a $LOG

if jack_control status | grep "stopped"
then
    notify-send -u critical "JACK Failed to Start"
    exit
fi

sleep 10

if [jack_control status | grep "stopped" ]; then
    notify-send -u "JACK Failed to Start"
    exit
fi

echo -e "Connecting a2j MIDI \n" >> $LOG
killall -9 a2jmidid
a2jmidid -ue & >> $LOG
sleep 10

pactl set-default-sink jack_out
echo "jack_out set as default sink" >> $LOG
pactl set-default-source jack_in
echo "jack_in set as default source" >> $LOG
#alsactl restore

notify-send "JACK Audio Connection Kit is connected and set for MIDI"
echo "Jack Setup Complete" >> $LOG
echo "Peripheral Check" >> $LOG
if [ -d "/proc/asound/Mic" ]; then
		echo "Samson Meteor Mic is Connected" >> $LOG
#		samson_ports & >> $LOG
fi

#echo -e "Starting Cadence \n" >> $LOG
#cadence --minimized &
#echo -e "Starting Qjackctl \n" >> $LOG
#qjackctl &

killall -9 aj-snapshot
echo "Enabling aj-snapshot for connection handling" >> $LOG
aj-snapshot -d $CONNECTIONS &

echo -e "Done \n" >> $LOG
echo `date` >> $LOG

exit 1
