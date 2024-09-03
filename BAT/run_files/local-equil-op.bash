#!/bin/bash

# try each eq step three time


try_id=1
while [ $try_id -le 3 ];
do
    if [ ! -f ./md00.chk ]; then
        echo "run equil-00 for $try_id time"
        python equil-00.py > output-00.dat
       
    fi
    let try_id=$try_id+1
done


i=1

while [ $i -le RANGE ] ;
do
    x=`printf "%02.0f" $i`
    try_id=1
    while [ $try_id -le 3 ];
    do
        if [ ! -f ./md$x.chk ]; then
            echo "run equil-$x for $try_id time"
            python equil-$x.py > output-$x.dat  
        fi
        let try_id=$try_id+1
    done
    
    let i=$i+1

done
