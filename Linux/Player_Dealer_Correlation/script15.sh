#script to search for 03/15 losses times
#Argument $1 = output file

echo 0315_Dealer_schedule >> $1
grep '05:00:00 AM\|08:00:00 AM\|02:00:00 PM' 0315_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}' >> $1

