#DEFINES
RANGE=10
WINRATE=10
MAXWINSTREAK=2 #needs - 1
winstreak=0

#functions
winclose () {
	first=$RANDOM
	let "first %= $RANGE"
	echo $first
	sleep 1
	second=$first
	echo $second
	sleep 1
	third=$first
	echo $third
	sleep 1
	winstreak=$((winstreak+1))
	echo "Your Winstreak is $winstreak !!!!"
	fim -a win.jpg
}

shuffle () {
	if [[ "$first" -eq "$second" ]]
	then
		second=$((second+1))
		if [[ "$second" -eq 10 ]]
		then
			second=0
		fi
		if [[ "$second" -eq -1 ]]
		then
			 second=9
		fi
	elif [[ "$first" -eq "$third" ]]
	then
		third=$((third+1))
		if [[ "$third" -eq 10 ]]
		then
			third=0
		fi
		if [[ "$third" -eq -1 ]]
		then
			 third=9
		fi
	elif [[ "$second" -eq "$third" ]]
	then
		third=$((third+1))
		if [[ "$third" -eq 10 ]]
		then
			third=0
		fi
		if [[ "$third" -eq -1 ]]
		then
			 third=9
		fi
	fi
}

loseclose () {
	first=$RANDOM
	second=$RANDOM
	third=$RANDOM
	let "first %= $RANGE"
	let "second %= $RANGE"
	let "third %= $RANGE"
	winstreak=0
	shuffle
	echo $first
	sleep 1
	echo $second
	sleep 1
	echo $third
	sleep 1
	echo LOOOOOOOOSE
	fim -a lose.jpg
}

play () {
	move=$RANDOM
	let "move %= 100"
	#echo $move
	if [[ move -le WINRATE ]] && [[ winstreak -le MAXWINSTREAK ]]
	then
		winclose
	else
		loseclose
	fi
}

#main
curl -s https://supercoolpics.com/wp-content/uploads/2015/10/272.jpg > win.jpg
curl -s https://pbs.twimg.com/media/DvgxT6EWkAE2iHA.jpg > lose.jpg

dpkg -s fim > /dev/null
fimstatus=$?
if [[ "$fimstatus" -eq 0 ]]
then
while [ true ]
do
	echo
	echo "Press enter to start game"
	echo "Enter 'q' to exit"
	read input
	if [[ "$input" = "q" ]]
	then
		break
	else
		play
	fi
done
else
echo .
echo .
echo .
echo "Please, install FIM: sudo apt-get install fim"
fi
