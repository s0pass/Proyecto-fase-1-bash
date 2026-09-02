#!/bin/bash

if [ "$1" = "-d" ]; then
    pkill -f "consolidar.sh"
    rm -rf "$HOME/EPNro1"
    echo "Entorno eliminado y proceso detenido"
    exit 0
fi

while true
do
    echo "=============================="
    echo "        MENÚ PRINCIPAL"
    echo "=============================="
    echo "1) Crear entorno"
    echo "2) Correr proceso"
    echo "3) Listar alumnos"
    echo "4) Mostrar 10 notas más altas"
    echo "5) Buscar alumno por padrón"
    echo "6) Visualizar log"
    echo "7) Salir"
    echo "=============================="
    
    read -p "Seleccione una opcion:" opcion
    
    case $opcion in
    1) cd ~                 # entra en home y crea carpetas y subcarpetas
       mkdir -p EPNro1
       cd EPNro1
       mkdir -p entrada salida procesado
       echo "Entorno creado correctamente"
       ;;
    
    2) cd ~/EPNro1          #se ejecuta consolidar.sh en segundo plano
       bash consolidar.sh &
       ;;
    
    3) 
       if [ -f "$HOME/EPNro1/salida/$FILENAME.txt" ]; then   # ordena por padron
          sort -n "$HOME/EPNro1/salida/$FILENAME.txt"
       else
           echo "No existe el archivo $FILENAME.txt"
       fi
       ;;

     4)
       if [ -f "$HOME/EPNro1/salida/$FILENAME.txt" ]; then           # muestra las 10 notas mas altas
            sort -k5 -nr "$HOME/EPNro1/salida/$FILENAME.txt" | head -10
       else
           echo "No existe el arhivo $FILENAME.txt"
       fi
       ;;
      
      5)
        read -p "Ingrese un numero de padron:" padron
        
        if [ -f "$HOME/EPNro1/salida/$FILENAME.txt" ]; then
            grep "^$padron " "$HOME/EPNro1/salida/$FILENAME.txt"    #busca alumno por padron
        else
            echo "No existe el archivo $FILENAME.txt"
        fi
        ;;
       
      6)
        if [ -f "$HOME/EPNro1/procesado.log" ]; then
            cat "$HOME/EPNro1/procesado.log"
        else
            echo "No existe el archivo de log"        # muestra el archivo .log
        fi
        ;;
      
      7)    
        break       # finaliza
        ;;
     
      *)
        echo "Opcion invalida"
        ;;
       
    esac
done
