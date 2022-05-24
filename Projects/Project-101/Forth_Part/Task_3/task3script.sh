#!/bin/bash
cat auth.log | grep "POSSIBLE BREAK"
cat auth.log | grep "POSSIBLE BREAK" | cut -d' ' -f7,12,13 | tee test.txt
cat test.txt | cut -d' ' -f1 | uniq
cat test.txt | cut -d' ' -f2 | uniq
cat test.txt | cut -d' ' -f3 | uniq
name1=$(cat test.txt | cut -d' ' -f1 | uniq | sed '3q;d') # find ip
times1=$(cat test.txt | grep -c ${name1}) # how many line occurences
echo ${name1} ${times1} >> invalid_user.sh # append both to file
name2=$(cat test.txt | cut -d' ' -f2 | uniq | tail -8 | sed '1q;d' | sed 's/[][]//g')
times2=$(cat test.txt | grep -c ${name2}) 
name3=$(cat test.txt | cut -d' ' -f2 | uniq | tail -8 | sed '2q;d' | sed 's/[][]//g')
times3=$(cat test.txt | grep -c ${name3})
name4=$(cat test.txt | cut -d' ' -f2 | uniq | tail -8 | sed '4q;d' | sed 's/[][]//g')
times4=$(cat test.txt | grep -c ${name4})
name5=$(cat test.txt | cut -d' ' -f2 | uniq | tail -8 | sed '8q;d' | sed 's/[][]//g')
times5=$(cat test.txt | grep -c ${name5})
echo ${name2} ${times2} >> invalid_user.sh
echo ${name3} ${times3} >> invalid_user.sh
echo ${name4} ${times4} >> invalid_user.sh
echo ${name5} ${times5} >> invalid_user.sh