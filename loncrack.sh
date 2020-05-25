#!/bin/bash
RAN=$(echo $RANDOM)
principal(){
echo
read -p "Digite o Hash completo: " HASH
echo
echo "$HASH" >> /tmp/.$RAN
SALT=$(cat /tmp/.$RAN | cut -d '$' -f3)
rm /tmp/.$RAN
echo "[1] MD5"
echo "[2] SHA-256"
echo "[3] SHA-512"
echo
read -p "Sua escolha => " ESCOLHA
case $ESCOLHA in
1) hash="md5" && crack;;
2) hash="sha-256" && crack;;
3) hash="sha-512" && crack;;
*) principal;;
esac
}
crack(){
echo
echo "[1] Wordlist"
echo "[2] Tentar a sorte"
echo "[3] Voltar"
echo
read -p "Sua escolha => " ESCOLHA
echo
case $ESCOLHA in
1) crackwordlist;;
2) cracksorte;;
3) principal;;
esac
}

crackwordlist(){
read -p "Informe uma Wordlist => " WORDLIST
echo
if [ ! -f $WORDLIST ]
then
crackwordlist
fi
LINES=$(wc -l $WORDLIST | cut -d ' ' -f1)
for i in `seq 1 $LINES`
do
PALAVRA=$(cat $WORDLIST | head -n$i | tail -n1)
VERIFICAR=$(mkpasswd -m $hash -S $SALT -s <<< $PALAVRA)
echo "Testando a Palavra => $PALAVRA"
if [ "$VERIFICAR" = "$HASH" ]
then
echo
echo -e "\033[01;32mSENHA ENCONTRADA => '$PALAVRA'\033[01;00m"
echo
exit
fi
done
echo
echo -e "\033[01;31mNENHUMA SENHA FOI ENCONTRADA! =C\033[01;00m"
echo
}
cracksorte(){
read -p "Informe a Palavra => " PALAVRA
VERIFICAR=$(mkpasswd -m $hash -S $SALT -s <<< $PALAVRA)
if [ "$VERIFICAR" = "$HASH" ]
then
echo
echo -e "\033[01;32mSENHA ENCONTRADA => '$PALAVRA'\033[01;00m"
echo
exit
else
echo
echo -e "\033[01;31mSENHA NÃO FOI ENCONTRADA! =C\033[01;00m"
echo
cracksorte
fi
}
principal
