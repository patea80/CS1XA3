#!/bin/bash
#cd back to CS1XA3 Directory (for general reference)
cd ..
#The number of files of each type is stored in the following variables (for function file_count)
html=0
javascript=0
python=0
haskell=0
bashscript=0

###############################################################################################################################################################################################################################################################
#this function counts the type of files located in the CS1XA3 directory
file_count () {
#nested for loop for looking through all files
for d in */ #iterates through all directories in CS1XA3
do
	for file in $d/* #iterates through all subdirectories in CS1XA3
	do
		if [[ -d $file ]] ; then #recursively checks for another directory, if so calls itself again
			cd $file
			cd ..
			file_count
		#if file of *.extension is found, added to stored variables
		elif [[ $file == *.html ]] ; then
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
}

###############################################################################################################################################################################################################################################################
#this function finds phrase "#TODO' and adds to todo.log, excludes certain files (todo.log, project_analyze.sh, and README.md)
todo_log () { grep -r --exclude={todo.log,project_analyze.sh,README.md} "#TODO" $pwd 1> ~/CS1XA3/Project01/todo.log
}

###############################################################################################################################################################################################################################################################
#this is implementaiton of custom feature, where it fetches information on stocks
custom_stock () {
loop=True
while [ $loop == True ] #loop that keeps reading input
do
	echo Enter stock ticker to find real time information on stock or enter 0 to exit back to the menu
	read ticker #reads stock ticker
	if [ $ticker == 0 ] ; then
		loop=False
	else
		echo 1 Month information on $ticker:
		curl -s "https://api.iextrading.com/1.0/stock/$ticker/chart/1m?format=csv" #gets information from api
		printf "\n\n\n"
		echo Current $ticker stock price:
		date
		echo $(tput setaf 2)$(curl -s https://www.marketwatch.com/investing/stock/$ticker |grep '<meta name="price" content="' |cut -d'"' -f4)$(tput sgr0) #gets price form marketwatch website, grepping price value
	fi
done
}

###############################################################################################################################################################################################################################################################
#this function finds all python and haskell files and compiles them
compile_error_log () {
for d in */ #iterates through directory
do
	for file in $d/* #iterates through subdirectories
	do
		if [[ -d $file ]] ; then #recursively checks for another directory, if so calls itself again
			cd $file
			compile_error_log
		elif [[ $file == *.py ]] ; then #checks for python extension
			python -m  py_compile $file 2>> ~/CS1XA3/Project01/compile_fail.log #compiles python file, and records any errors to compile .log
			if [[ $? == 0 ]] ; then
				rm $d/*.pyc #if compiles, removes compiled extensions
			fi
		elif [[ $file == *.hs ]] ; then #checks for haskell extension
			ghc -o hi $file 2>> ~/CS1XA3/Project01/compile_fail.log #compiles haskell file, and records any errors to complile_fail.log
			if [[ $? == 0 ]] ; then
				rm $d/*.hi #if compiles, removes compliled extension
				rm $d/*.o
				rm hi
			fi
		fi
	done;
done;
cd ~/CS1XA3 #goes back to reference point when done recursion
}

###############################################################################################################################################################################################################################################################
#this is the main menu loop
choice=1
while [ $choice != 0 ] #loop for user input
do
	#user instructions
	echo Press 0 to exit
	echo Press 5.0 to run custom script Stock Quote Fetcher
	echo Press 5.2 to run script Create a TODO Log
	echo Press 5.3 to run script Compile Error
	echo Press 5.5 to run script File Type Count
	read choice #reads user input
	#calls function according to user input
	if [ $choice == 5.2 ] ; then
		echo Running script $choice Create a TODO Log...
		todo_log
		printf "\n"
		echo "Done."
	elif [ $choice == 5.5 ] ; then
		echo Running script $choice File Type Count in CS1XA3 directory...
		file_count
		echo HTML: $html , JavaScript: $javascript, Python: $python, Haskell: $haskell, Bashscript: $bashscript
		printf "\n"
		echo "Done."
	elif [ $choice == 5.0 ] ; then
		echo Running script $choice Stock Quote Fetcher...
		custom_stock
		printf "\n"
		echo "Done."
	elif [ $choice == 0 ] ; then
		echo $(tput setaf 1)Terminated.
	elif [ $choice == 5.3 ] ; then
		echo Running script $choice Compile Error Log...
		compile_error_log
		printf "\n"
		echo "Done."
	else
		echo Invalid input, try again! #if none of the choices above are chosen
	fi
printf "\n\n\n"
done


