#!/bin/bash


# i es la bandera para el while principal
i=0
export FILENAME="alumnos"
# se engloba todo el codigo con un while y un sistema de flag(banderas) para que se siga ejecutando el meno hasta que se elija la opcion 7 (salir)
while [ $i -eq 0 ]; do
    echo "ingrese 1 para crear entorno "
    echo "ingrese 2 para correr proceso "
    echo "ingrese 3 para Listar alumnos "
    echo "ingrese 4 Mostrar 10 notas más altas "
    echo "ingrese 5 Buscar alumno por padrón "
    echo "ingrese 6 Visualizar log "
    echo "ingrese 7 para salir "
    read menu


    case $menu in
        1) 
            #se crean las carpetas con la funcion mkdir en funcion de la direccion indicada
            mkdir -p ~/EPNro1
            mkdir -p ~/EPNro1/entrada
            mkdir -p ~/EPNro1/salida
            mkdir -p ~/EPNro1/procesado
            echo "entorno creado"
            ;;
        2)
            # verifica si el proceso consolidar.sh ya se esta en ejecucion gracias al pgrep que verifica si el comando termino con verdadero o falso
            if  pgrep -f "consolidar.sh" > /dev/null ; then
                echo "proceso ya en ejecucion"
            else
                echo "iniciano proceso"
                # el signo & le ordena a linux que ejecute el comando en segundo plano (proseso de background)
                bash ~/EPNro1/consolidar.sh & 
                # el $! es una variable especial que tiene la funcion de guardar el id del ultimo proseso ejecutado en segundo plano, es importante para matar este proceso en la linea 7
                PID_CONSOLIDAR=$!
            fi
            ;;
            
        3)
            if [ -f "$HOME/EPNro1/salida/$FILENAME.txt" ]; then
                # la funcion sort ordena alfabeticamente pero junto al -n lo ordena numericamente de mayor a menor
                sort -n "$HOME/EPNro1/salida/$FILENAME.txt"
            else
                echo "No existe el archivo"
            fi
            ;;
        4)
            # Reemplazamos la tilde por $HOME y corregimos FILENAME
            salida="$HOME/EPNro1/salida/$FILENAME.txt"
        
            if [ -f "$salida" ]; then
                echo "Las 10 notas más altas:"
             
                sort -k5,5nr "$salida" | head -n 10
            else
                echo "Error: el archivo $salida no existe"
            fi
        ;;
        5)
            salida="$HOME/EPNro1/salida/$FILENAME.txt"
        
            if [ -f "$salida" ]; then
                read -p "Ingrese el número de padrón: " padron
            
            if [ -z "$padron" ]; then
                echo "Se debe ingresar un número válido"
            else
                echo "Buscando padrón..."
                grep "^$padron\b" "$carpeta_salida" || echo "El padrón $padron no se encontró"
            fi
            else
                echo "Error: el archivo $carpeta_salida no existe"
            fi
            ;;
        6)
            LOG="$HOME/EPNro1/procesado.log"

            if [ -f "$LOG" ]; then
            echo "CONTENIDO DEL LOG:  "
            cat "$LOG"
            else
                echo "No existe el archivo de log."
            fi
            ;;
        7)
            # aca se cambia el valor de la vandera para que salga del while por ende terminando el programa
            i=1
            echo "saliendo..."
            # se verifica que con el -n  que el id del scrip consolidar.sh exista y si este esta en proceso entra al if
            if [ -n "$PID_CONSOLIDAR" ]; then
            # el comando kill mata el proceso en segundo plano consolidar.sh al momento de salir para que no se siga ejecutando de forma inecesaria
                kill "$PID_CONSOLIDAR" 2>/dev/null
                echo "Procesos detenidos."
            fi  
            ;;
        
    esac
done