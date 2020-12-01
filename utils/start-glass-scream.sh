#! /usr/bin/env bash

sudo virsh start ragnarok
looking-glass-client win:size=1920x1080 >/dev/null 2>&1 &
scream-alsa -i virbr0 &

wait -n
pkill -P $$
