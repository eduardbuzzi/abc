#!/bin/bash

read -p "Informe a Wordlist: " WORDLIST
for url in $(cat $WORDLIST);
do
host $url.$1 | grep "has adress"
done
