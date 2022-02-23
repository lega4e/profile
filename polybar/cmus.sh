#!/bin/bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Settings ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

trim_length=30
time_reverse=1 # 0 or 1



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

prepend_zero()
{
  seq -f "%02g" $1 $1
}

trim()
{
  echo $1 | sed -e 's/^\s\+//;s/\s\+$//'
}

# $1=position $2=duration $3=reverse (0 or 1)
duration_straight()
{
  [ "$3" -eq 1 ] && pos=$(($2-$1)) && prefix="-" || pos=$1
  mins1=$(prepend_zero $((pos / 60)))
  secs1=$(prepend_zero $((pos % 60)))
  mins2=$(prepend_zero $(($2 / 60)))
  secs2=$(prepend_zero $(($2 % 60)))
  echo "$prefix$mins1:$secs1/$mins2:$secs2"
}



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Calculating ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

status=$(echo -n $(cmus-remote -C status | grep "status"          | cut -c 8-))
artist=$(echo -n $(cmus-remote -C status | grep "tag albumartist" | cut -c 17-))

if [ $status == 'playing' -o $status == 'paused' ]
then
  # calculate artist-song string
  song=$(echo -n $(cmus-remote -C status | grep title | cut -c 11-))
  songart="$artist — $song"
  [ ${#songart} -ge $trim_length ] && songart=`trim "${songart:0:$((trim_length-1))}"`…

  # calculate time string
  position=$(cmus-remote -C status | grep position | cut -c 10-)
  duration=$(cmus-remote -C status | grep duration | cut -c 10-)
  time=`duration_straight $position $duration $time_reverse`

  echo "$songart $time"
else
  echo
fi



# END
