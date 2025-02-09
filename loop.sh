#!/bin/bash

<<help

This script is for loop
loops : Anything that you want to repeat 
for loop conditions
1 .... 10 or 5 ... 1

starting point = 1
ending point = 10
increment/decrement

help

echo "This is a loop program"

for (( num=1 ; num<=10 ; num++ ))
do
	echo "$num"
	echo "hello"
done
