#!/bin/sh

####################################################################
#
# Uzduotis: is duoto failo atspausdinti tik tas eilutes, kuriose 
#           simboliu kiekis eiluteje yra lyginis.
#
#
# Tomas Petras Rupsys
# Matematine Informatika
# Matematikos ir Informatikos Fakultetas
# Vilniaus universitetas
#
#####################################################################


FILE=$1
WHITESPACE_IS_SYMBOL=1 # false

# Tikrina ar duoti parametrai komandai yra teisingi
cmdParametersAreValid() {
  if [ -n "$FILE" ] && [ -f $FILE ];
    then return 0
    else return 1
  fi
}

# Spausdina informacija pradzioje
printIntro() {
  echo "\n\nSpausdiname eilutes, kuriose simboliu kiekis yra lyginis:"
}

# Iseina is shell programos. Funkcijai butina nurodyti isejimo koda
# ir isejimo zinute.
quit() {
  local exit_code=$1
  local exit_message="$2"

  echo "\n\nIsjungiama programa: $exit_message\n\n"
  exit $exit_code
}

# Pasalina tuscius simbolius is eilutes
removeWhitespacesIfNeeded() {
  echo `echo "$1" | tr -d ' '`
}

# Grazina boolean reiksme pagal tai, ar eiluteje yra lyginis kiekis 
# simboliu ar ne.
stringLengthIsEven() {
  local string="$1"
  if [ $WHITESPACE_IS_SYMBOL -eq 1 ];
    then string=`removeWhitespacesIfNeeded "$1"` 
  fi

  local string_length=${#string}

  if [ `expr $string_length % 2` -eq 0 ];
    then return 0
    else return 1
  fi
}

# Iteruoja per failo eilutes ir spausdina jeigu simboliu kiekis lyginis
iterateFileAndPrintLinesIfEven() {
  while read LINE
  do
    if stringLengthIsEven "$LINE"; then echo "$LINE"; fi
  done < $FILE
}

# Programos veikimas
if cmdParametersAreValid;
then
  printIntro
  echo "---------------------------------------------------------"
  iterateFileAndPrintLinesIfEven
  echo "---------------------------------------------------------"
  quit "0" "darbas baigtas sekmingai"
else
  quit "1" "programos panaudojimas: ./pirmoji.sh FAILO_PAVADINIMAS"
fi 

