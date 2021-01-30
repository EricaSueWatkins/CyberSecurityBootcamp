#03/10 script to find dealers for the times of the losses
#Arguments $1 = output file

echo 0310_Dealer_schedule >> $1
grep '05:00:00 AM\|08:00:00 AM\|02:00:00 PM\|08:00:00 PM\|11:00:00 PM' 0310_Dealer_schedule | awk -F" " '{print $1, $2, $5, $6}' >> $1

