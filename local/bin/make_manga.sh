#!/bin/bash

for dir in $(ls)
do
    cd ${dir}

    pdfs=""

    for image in $(ls *) ; do
        soffice --headless --convert-to pdf ${image} > /dev/null
        rm ${image}
        pdfs="${pdfs} $(echo ${image} | cut --delimiter="." --fields=1).pdf"
    done

    pdftk ${pdfs} cat output "${dir}.pdf"

    rm ${pdfs}

    mv "./${dir}.pdf" ..

    cd ..

    rmdir ${dir}

done

tree
