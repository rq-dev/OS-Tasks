#!/bin/bash

if [[ "$1" == "-h" || "$1" == "--help" ]]
then
echo "СПРАВКА:"
echo ""
echo "Скрипт находит в заданной директории все подкаталоги первого уровня, в которых не открыт ни один файл."
echo "[shardcollect.sh] [directory] - программа находит и выводит все подкаталоги первого уровня директории directory, в которых не открыт ни один файл"
echo "[shardcollect.sh] - программа находит и выводит все подкаталоги первого уровня текущей директории, в которых не открыт ни один файл."
echo "Для справки используйте -h или --help."
echo ""
exit 0
fi

if [ "$1" == "" ]
then
d=$PWD
else
if [ ! -d "$1" ]
then
echo "Директория $1 не найдена!"
exit 0
else
d=$1
fi
fi

dirs=$(find "$d" -maxdepth 1 -mindepth 1 -type d )
used=$(lsof +D "$dirs" 2>/dev/null | awk '{print $9} 2>/dev/null')
for d in $dirs
do
r=$(echo "$used" | grep -w "$d")
if [ "$r" == "" ]
then
res+=" $d"
fi
done

if [ "$res" == "" ]
then
exit 3
else
echo "$res" | sed 's/ /\n/g'
fi
