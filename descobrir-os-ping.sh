#!/bin/bash
principal(){
echo
read -p "Informe a Wordlist de IPs para tentar descobrir o OS => " WORDLIST
if [ ! -f $WORDLIST ]
then
principal
else
echo
LINES=$(wc -l $WORDLIST | cut -d ' ' -f1)
for i in `seq 1 $LINES`
do
HOST=$(cat $WORDLIST | head -n$i | tail -n1)
TESTE=$(nmap -sn -v $HOST | grep "up" | cut -d ' ' -f3 | head -n1 | tail -n1)
if [ "$TESTE" = "up" ]
then
PING=$(ping -c1 $HOST | grep "ttl" | cut -d "=" -f3 | cut -d ' ' -f1)
if [ "$PING" = "64" ]
then
echo "IP: $HOST => Linux"
fi
if [ "$PING" = "254" ]
then
echo "IP: $HOST => Cisco"
fi
if [ "$PING" = "32" ]
then
echo "IP: $HOST => Windows"
fi
if [ "$PING" = "128" ]
then
echo "IP: $HOST => Windows"
fi
if [ -z "$PING" ]
then
continue
fi
if [ -n "$PING" ] && [ ! "$PING" = "32" ] && [ ! "$PING" = "64" ] && [ ! "$PING" = "128" ] && [ ! "$PING" = "254" ]
then
echo "IP: $HOST => TTL: $PING DIFERENTE!"
fi
fi
done
fi
echo
}
principal
