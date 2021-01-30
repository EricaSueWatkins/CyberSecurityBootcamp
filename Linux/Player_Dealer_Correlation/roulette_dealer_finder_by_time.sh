#script to find roulette dealer by day/time
#Instructions for script: roulette_dealer_finder_by_time.sh

#Argument1: $1 Time Format: 01-12
#Argument2: $2 AM/PM Format: A or P
#Argument3: $3 Date Format: 0312
#Argument4: $4 Output File

grep "$1\:00:00 $2\M" $3* | awk -F" " '{print $1, $2, $5, $6}' >> $4

