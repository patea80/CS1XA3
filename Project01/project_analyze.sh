#!/bin/bash
cd ..
file_count () {
html=0
javascript=0
python=0
haskell=0
bashscript=0
#find * -type f -print0 | while IFS= read -d $'\0' file
	for d in */
	do
		for file in $d/*
		do
			if [[ $file == *.html ]] ; then
				html=$((++html))
			elif [[ $file == *.js ]] ; then
				javascript=$((++javascript))
			elif [[ $file == *.py ]] ; then
				python=$((++python))
			elif [[ $file == *.hs ]] ; then
				haskell=$((++haskell))
			elif [[ $file == *.sh ]] ; then
				bashscript=$((++bashscript))
			fi
		done;
	done;
printf "\n\n\n"
echo HTML: $html , JavaScript: $javascript, Python: $python, Haskell: $haskell, Bashscript: $bashscript
}

todo_log () {
grep -r --exclude={todo.log,project_analyze.sh,README.md} "#TODO" $pwd 1> Project01/todo.log 
}

choice=1
while [ $choice != 0 ]
do
	echo Press 0 to exit
	echo Press 5.2 to run script Create a TODO Log
	echo Press 5.5 to run script File Type Count
	read choice
	if [ $choice == 5.2 ] ; then
		echo Running script $choice Create a TODO Log...
		todo_log
		printf "\n"
		echo "Done."
	elif [ $choice == 5.5 ] ; then
		echo Running script $choice File Type Count in CS1XA3 directory...
		file_count
		printf "\n"
		echo "Done."
	elif [ $choice == 0 ] ; then
		echo Terminated.
	else
		echo Invalid input, try again!
	fi
printf "\n\n\n"
done


