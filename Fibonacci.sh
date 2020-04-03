#!/bin/bash

if [[ "$1" = "-h" || "$1" = "--help" ]]
then
echo   Находит n-ый  элемент последовательности Фибоначчи
exit 0
fi

if [[ "$1" = ""  || "$1" = "0" ]]
then
echo Empty arg or zero arg!
exit 0
fi

if [[ "$1" -le "0" ]]
then
echo negative args.
exit 0
fi


n=1
result=0

for ((i=1; $i<$1; i++))
do
let "result = result + n"
let "n = result - n"
done

echo $result

