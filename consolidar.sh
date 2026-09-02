#!/bin/bash

while true
do
    for archivo in ~/EPNro1/entrada/*.txt
    do
        if [ -f "$archivo" ]; then

            cat "$archivo" >> ~/EPNro1/salida/$FILENAME.txt

            echo "$(date '+%d/%m/%Y %H:%M:%S') - Procesado: $(basename "$archivo")" >> ~/EPNro1/procesado.log

            mv "$archivo" ~/EPNro1/procesado/

        fi
    done

    sleep 2
done
