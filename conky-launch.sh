#!/bin/bash

killall -q conky
echo "---" >> /tmp/conky.log
conky -c ~/.config/conky/default.conf 2>&1 >> /tmp/conky.log & disown
echo "Conky launched..."

# END
