#!/bin/bash

if [ "$1" == "" ]
then
	echo "No arguments"
	echo "For help use --help or -h"	
    exit 0
	fi

if [[ "$1" == "-h" || "$1" == "--help" ]]
then
	echo "***********************************************************"
	echo 
	echo "Locator.sh [File name]"
	echo "Locator.sh checks which command is external/internal"
	echo "For help use --help or -h"
	echo
	echo "***********************************************************"	
	exit 0
	fi

IFS=:

help $1 2>/dev/null | grep "$1:"&>/dev/null

if [ "$?" == "0" ]
then
	echo "Internal command"
	exit 0
fi

m=1

for x in $PATH
	do
	if [[ -x $x/${1##*/} && ! -d $x/${1##*/} ]]
	then
	echo "External command"
	echo "$x/${1##*/}"
	m=0
	fi	
done
	
	

if [ "$m" == "1" ]
then
if  [ -f "$1" ]
then
	readlink -f $1
else
	echo "File not found"
	fi
fi
