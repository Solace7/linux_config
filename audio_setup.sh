#!/bin/bash
exec cadence-session-start --start
exec --no-startup-id aj-snapshot -d /home/solace/Documents/Projects/Audio/ajsnapshots/default
