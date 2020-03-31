#!/bin/bash

if [[ "$1" == "-h" || "$1" == "--help" ]]
then
	echo "***********************************************************"
	echo ""
	echo "Loganalyser.sh [logfile.txt] [source]"
	echo "logfile.txt - лог сервера."
	echo "Находит медиану по времени обработки запроса для указанного в параметрах source в файле с логами."
	echo "Если параметр source не указан, то поиск осуществляется для всех source."	
	echo ""
	echo "***********************************************************"
	exit 0
fi

if [ "$1" = "" ] || [ ! -f $1 ]; then
  echo "File not found!"
  exit 0
fi

num1=`cut -f5 -d"|" $1 | cut -f2 -d" " | sort -n | awk NR\ ==\ $h1\ `
num2=`cut -f5 -d"|" $1 | cut -f2 -d" " | sort -n | awk NR\ ==\ $h2\ `

if [ "$2" == "" ]
then
count=`cut -f5 -d"|" $1 | sort -nr | wc -l`
rem=`expr $count % 2`
let "h1=$count/2"
let "h2=$h1+1"


if [ $rem == "0" ]
then 
res=`echo "scale=4; ($num1+$num2)/2" |bc`
echo "Median is $res"
else
echo "Median is $num2"
exit 0
fi

else

count=`grep -w $2 $1 | cut -f5 -d"|" | sort -nr | wc -l`

if [ "$count" == "0" ]
then
echo "There is not such source!"
exit 0
fi

rem=`expr $count % 2`
let "h1=$count/2"
let "h2=$h1+1"
num1=`grep -w $2 $num1`
num2=`grep -w $2 $num2`

if [ $rem == "0" ]
then 
res=`echo "scale=4; ($num1+$num2)/2" |bc`
echo "Median is $res"
else
echo "Median is $num2"
exit 0
fi

exit 0
fi
