#bonus script to find dealer by day/time/game
#Instructions for bonus script: dealer_finder_by_time_by_game.sh

#Argument1: Game Type Format: roulette, blackjack, or holdem
#Argument2: Time Format: 01-12
#Argument3: AM/PM Format: A or P
#Argument4: Date Format: 0312
#Argument5: Output File

find $4* >> $5
if [ $1 == roulette ]; 
then grep "$2\:00:00 $3\M" $4* | awk -F" " '{print "Roulette Dealer:", $1, $2, $5, $6}' >> $5
elif [ $1 == blackjack ];
then grep "$2\:00:00 $3\M" $4* | awk -F" " '{print "BlackJack Dealer:", $1, $2, $3, $4}' >> $5
elif [ $1 == holdem ];
then grep "$2\:00:00 $3\M" $4* | awk -F" " '{print "Texas Hold-em Dealer:", $1, $2, $7, $8}' >> $5
else echo "Invalid Game Input"
fi

