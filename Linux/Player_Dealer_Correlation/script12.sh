#script to find roulette dealers at the times of loss for 03/12
#Argument $1 = output file

echo 0312_Dealer_schedule >> $1
grep '05:00:00 AM\|08:00:00 AM\|02:00:00 PM\|08:00:00 PM\|11:00:00 PM' 0312_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}' >> $1

