#!/bin/bash
exec cadence-session-start --start
exec aj-snapshot -d /home/solace/Documents/Projects/Audio/ajsnapshots/default
cadence
noify-send "JACK Audio Started"
