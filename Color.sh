#!/bin/bash
for i in {30..37} {90..97}
do
echo
for j in {40..47} {100..107}
do
echo -en "\e[5;${i};${j}m COLOR "
echo -en "\e[0m"
done
done
echo
