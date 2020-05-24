#!/bin/bash
principal() {
echo
echo "[1] Codificar MD5"
echo "[2] Codificar SHA1"
echo "[3] Decodificar MD5"
echo "[4] Decodificar SHA1"
echo "[5] Sair"
echo
read -p "Sua Escolha => " ESCOLHA
echo
case $ESCOLHA in
1) md5choice;;
2) sha1choice;;
3) md5decodificar;;
4) sha1decodificar;;
5) exit;;
*) principal;;
esac
}

codificar(){
read -p "Mensagem que deseja criar Hash em $HASH => " MENSAGEM
echo
HASHGERADA=$(echo -n "$MENSAGEM" | $hash"sum" | cut -d ' ' -f1)
echo "Hash gerada em $HASH para a mensagem '$MENSAGEM' => '$HASHGERADA'"
principal
}

md5choice(){
HASH="MD5"
hash="md5"
codificar
}

sha1choice(){
HASH="SHA1"
hash="sha1"
codificar
}

md5decodificar(){
HASH="MD5"
hash="md5"
CARACTERES=32
decodificar
}

sha1decodificar(){
HASH="SHA1"
hash="sha1"
CARACTERES=40
decodificar
}

decodificar(){
read -p "Informe a Hash em $HASH => " HASHZERA
echo
if [ ${#HASHZERA} -ne $CARACTERES ]
then
echo "O que você informou não é uma Hash $HASH"
principal
fi
echo "[1] Tentar a sorte digitando palavras"
echo "[2] Verificar palavras de uma Wordlist"
echo "[3] Voltar"
echo
read -p "Sua Escolha => " ESCOLHA
echo
case $ESCOLHA in
1) decodificarSORTE;;
2) decodificarWL;;
3) principal;;
esac
}

decodificarSORTE(){
read -p "Informe uma palavra ou frase => " INFORMADO
echo
HASHINFORMADO=$(echo -n "$INFORMADO" | $hash"sum" | cut -d ' ' -f1)
if [ "$HASHINFORMADO" = "$HASHZERA" ]
then
echo -e "\033[01;32mA Hash $HASHZERA decodificada é => '$INFORMADO'\033[01;00m"
principal
else
echo -e "\033[01;31mA Hash $HASHZERA não tem nada a ver com '$INFORMADO'\033[01;00m"
echo
decodificarSORTE
fi
}

decodificarWL(){
read -p "Informe uma Wordlist => " WORDLIST
echo
if [ ! -f "$WORDLIST" ]
then
echo
decodificarWL
fi
LINES=$(wc -l $WORDLIST | cut -d ' ' -f1)
for i in `seq 1 $LINES`
do
PALAVRA=$(cat $WORDLIST | head -n$i | tail -n1)
HASHPALAVRA=$(echo -n "$PALAVRA" | $hash"sum" | cut -d ' ' -f1)
if [ "$HASHPALAVRA" = "$HASHZERA" ]
then
echo -e "\033[01;32mA Hash $HASHZERA decodificada é => '$PALAVRA'\033[01;00m"
principal
fi
done
echo -e "\033[01;31mNão foi encontrada nenhuma palavra na Wordlist para a Hash $HASHZERA\033[01;00m"
echo
decodificar
}
principal
