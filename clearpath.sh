#!/bin/bash

if [[ "$1" == "-h" || "$1" == "--help" ]]
then
	echo "***********************************************************"
	echo ""
	echo "clearpath.sh [dir]"
	echo "clearpath.sh - программа выводит на экран очищенный от всего «лишнего» PATH и завершает работу."
	echo "clearpath.sh [dir] - программа выводит на экран очищенное от всего «лишнего» содержимое переданного аргумента
и завершает работу."
	echo "For help use --help or -h"
	echo "***********************************************************"
	exit 0
fi

if [ "$1" == "" ]
then
p=$PATH
else
if [ "${*+1}" != "" ]
then
p+=" $*"
shift 1
else
p=$1
fi
fi

p=$(echo "$p" | tr ':' '\n' | awk '!($0 in a) {a[$0];print}')

IFS=$'\n'

for d in $p
do
c=0
for f in $(find "$d" 2>/dev/null)
do
if [[ -x $f && -f $f ]] 2>/dev/null
then
c=$(($c+1))
fi
done
if [ "$c" != "0" ]
then
newpath+=":$d"
fi
done
echo $newpath | cut -c 2- 
unset IFS
