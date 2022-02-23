#!/bin/bash

killall -q polybar
echo "---" | tee -a /tmp/polybar.log
polybar master 2>&1 | tee -a /tmp/polybar1.log & disown
echo "Bars launched..."

# END
