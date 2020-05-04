#!/bin/bash
principal () {
echo
read -p "Informe o site: " SITE
SITEUP=$(host $SITE | cut -d ' ' -f4 | head -n1)
if [ $SITEUP = 'found:' ]
then
principal
fi
read -p "Informe a wordlist: " WORDLIST
if [ ! -f "$WORDLIST" ] 
then
principal
fi
for palavra in $(cat $WORDLIST)
do
resposta=$(curl -s -o /dev/null -w "%{http_code}" $SITE/$palavra/)
if [ $resposta == "200" ]
then
echo "Diretorio encontrado: $palavra"
fi
resposta2=$(curl -s -o /dev/null -w "%{http_code}" $SITE/$palavra)
if [ $resposta2 == "200" ]
then
echo "Arquivo encontrado: $palavra"
fi
done
}
principal
