#!/bin/bash

if [[ "$1" == "-h" || "$1" == "--help" ]]
then
	echo "***********************************************************"
	echo ""
	echo "Imagemagick.sh [output dir] ["text"] [result dir] [font] [font size]"
	echo "Add text to the right bottom corner of image"
	echo "Text must be in quotes."
	echo "[font] and [font size] not required. But if you type incorrect these arguments incorrect, default parameters will be used"
	echo "Default font is DejaVu-Serif-Bold"
	echo "Default font size is 100"
	echo "For info of which font you can use following command convert -list font. If typed font is incorrect then default will be used."
	echo "***********************************************************"
	exit 0
fi

if [ "$1" == "" ] || [ "$2" == "" ] || [ "$3" == "" ]
then
	echo "No arguments"
	echo "For help use --help or -h"
    exit 0
fi

if [ "$4" == "" ]
then
ff=DejaVu-Serif-Bold
fs=100
else

echo "$4" > if.txt
fx=`grep -c "0\|1\|2\|3\|4\|5\|6\|7\|8\|9" if.txt`
if [ "$fx" != 0 ]
then
fs=$4
rm if.txt
if [ "$5" == "" ]
then
ff=DejaVu-Serif-Bold
else
ff=$5
fi

else
 ff=$4
 if [ "$5" == "" ]
then
fs=100
else
echo "$5" > ifsss.txt
fx2=`grep -c "0\|1\|2\|3\|4\|5\|6\|7\|8\|9" ifsss.txt`
if [ "$fx2" == "0" ]
then
fs=100
rm ifsss.txt
else
fs=$5
fi
fi  
 fi    
fi

IFS=:

if ! [ -d $1 ]; then
echo "Invalid sours dir "
exit 0
fi

if ! [ -d $3 ]; then
mkdir $3
fi

mkdir $3/tmp123451231213123123123124123189889781979321qwe
for f in $1/*
do
a=`identify $f > imtemp.txt 2>/dev/null`
b=`grep -c JPEG imtemp.txt`
if [ "$b" != "0" ]
then
cp $f $3/tmp123451231213123123123124123189889781979321qwe 2>/dev/null
fi
done
rm imtemp.txt 2>/dev/null

for f in $3/tmp123451231213123123123124123189889781979321qwe/*
do
mv $f ${f%.*}_annotated.jpg 2>/dev/null
done

for f in $3/tmp123451231213123123123124123189889781979321qwe/*
do
cp $f $3 2>/dev/null
done
rm -R $3/tmp123451231213123123123124123189889781979321qwe 2>/dev/null




for f in $3/*
do
convert -pointsize $fs -font $ff -fill yellow -gravity SouthEast -annotate +0+5 $2  $f $f 2>/dev/null
done
