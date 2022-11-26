#!/usr/bin/env bash

# Vars
declare -l main_string
count=1;

# Working Dir
cd /tmp
mkdir Zips
mv *.zip Zips
cd Zips

for chapter in $(ls *.zip)
do
  mkdir MYMANGA
  mv ${chapter} MYMANGA
  cd MYMANGA

  empty_string=""

  main_string=$(ls ${chapter} | cut -f 1 -d ".")"_"
  chapter_name=$(head -n ${count} /tmp/chap_names.txt | tail -n 1)
  final=Chapter_$(echo ${main_string} | cut -f 2 -d "_")-"${chapter_name}".pdf

  ((count++))

  unzip ${chapter} > /dev/null
  rm ${chapter}
  pages=$(ls | wc -l)

  for item in $(ls) 
  do
    soffice --headless --convert-to pdf ${item} > /dev/null
    rm ${item}
  done

  for page in $(seq 1 ${pages})
  do
    empty_string+="${main_string}${page}.pdf "
  done

  pdftk ${empty_string} cat output "${final}"

  mv "${final}" /home/nikin/books/Mangas/Naruto/

  cd ..
  rm -rf MYMANGA
done

cd /tmp/
rm -rf chap_names.txt Zips
