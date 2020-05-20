#!/bin/bash
principal(){
RAN=$(shuf -i 1-10000 -n1)
echo
read -p "Informe a Wordlist que contêm IPs => " WORDLIST
if [ ! -f $WORDLIST ]
then
principal
else
echo
LINES=$(wc -l $WORDLIST | cut -d ' ' -f1)
for i in `seq 1 $LINES`
do
HOST=$(cat $WORDLIST | head -n$i | tail -n1)
nmapATIVOS=$(nmap -v -sn $HOST | grep "Host is up")
if [ -n "$nmapATIVOS" ]
then
echo "$HOST está ONLINE!"
fi
done
fi
echo
}
principal
