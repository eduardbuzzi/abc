#!/bin/bash
principal(){
RAN=$(shuf -i 1-10000 -n1)
IP=$(hostname -I | cut -d ' ' -f1)
echo
echo "Seu IP => $IP"
echo
echo "== NMAP ATIVO =="
echo "192.168.1.1,2,3"
echo "192.168.1.1-20"
echo "192.168.1.0/24"
echo
read -p "Informe o range de IPs => " RANGE
read -p "Deseja salvar os IPs ativos em uma WL? (s/n) => " CHOICE
echo
case $CHOICE in
[sS]) salvar;;
[nN]) naosalvar;;
*) principal;;
esac
}

verificar(){
nmapATIVOS=$(nmap -v -sn $RANGE -oG .nmap$RAN)
IPsATIVOS=$(cat .nmap$RAN | grep "Up" | cut -d ' ' -f2)
rm .nmap$RAN 2> /dev/null
echo "$IPsATIVOS" >> .nmap$RAN
LINES=$(wc -l .nmap$RAN | cut -d ' ' -f1)
for i in `seq 1 $LINES`
do
PEGAR=$(cat .nmap$RAN | head -n$i | tail -n1)
echo "IP: $PEGAR está Online"
done
}

salvar(){
verificar
echo
read -p "Onde você deseja salvar a Wordlist com os IPs? => " LOCAL
echo "$IPsATIVOS" >> $LOCAL
echo "IPs Ativos salvos na Wordlist => $LOCAL"
echo
}

naosalvar(){
verificar
echo
}
principal
