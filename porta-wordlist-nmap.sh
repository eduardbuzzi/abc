#!/bin/bash
principal () {
echo
read -p "Informe a Wordlist: " WORDLIST
if [ ! -f "$WORDLIST" ]
then
principal
else
echo
read -p "Informe a Porta: " PORTA
echo
LINES=$(wc -l $WORDLIST | cut -d ' ' -f1)
for i in `seq 1 $LINES`
do
IP=$(cat $WORDLIST | head -n$i | tail -n1)
NMAP=$(nmap --open -sS -Pn -p $PORTA $IP | cut -d ' ' -f2 | head -n2 | tail -n1)
if [ "$NMAP" = 'scan' ]
then
echo "$IP => Tem a PORTA $PORTA ABERTA!"
fi
done
echo
fi
}
principal
