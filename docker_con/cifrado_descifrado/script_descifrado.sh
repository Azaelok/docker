#!/bin/bash
echo ""
echo "Componente para Descifrado"
var_dia=`date +"%d/%m/%Y_%H:%M:%S"`
descifrado_INBOX(){

  #PARAMETRIA DESCIFRADO
  #-----------------
  #diredescifr="/home/master/inbox/"
  #pass_desc="/home/master/inbox/passphrase/pgpassD"
  #respaldoDesc="/home/master/inbox/respaldoPGP/"
  #logDesc="/home/master/inbox/logsDecifrado/"
  diredescifr=$1
  pass_desc=$2
  respaldoDesc=$3
  logDesc=$4

  cd $diredescifr;
	dia_actual=`date +"%Y%m%d_%H%M%S"`;
	exec > >(tee -i $logDesc"`basename $0`_"$dia_actual".log" )
    echo "Proceso de Descifrado.";
    echo "Fecha ejecucion: $var_dia";
    if [ ! -d $diredescifr ]; then
      echo "El directorio no existe";
    else
      numero_archivos_pgp=($(find $diredescifr -maxdepth 1 -type f -iname "*.pgp"));
      if [ ${#numero_archivos_pgp[@]} -eq 0 ]; then
        echo "No existen archivos para descifrar en el buzon INBOX!."
      else
        echo "Numero de archivos para descifrar en el buzon INBOX: ${#numero_archivos_pgp[@]}";
        echo "----------------------------------------------------------";
        for i in "${numero_archivos_pgp[@]}"
        do
          nombre=$(basename "$i");
          sig=`echo $nombre | sed -e 's/\.[^.]*$//'`;
          gpg --batch --pinentry-mode loopback --passphrase-file $pass_desc -o $sig -d $nombre;
          if [ ! -f $diredescifr$sig ]; then
              echo "No se pudo descifrar el archivo: "$sig;
          else
            plano=`echo $sig | sed -e 's/\.[^.]*$//'`;
            gpg --output $plano --decrypt $sig;
            if [ ! -f $diredescifr$sig ]; then
                  echo "No se pudo verificar la firrma digital del archivo: "$plano".sig";
            else
                  echo "Archivo cifrado:	$nombre";
                  echo "Archivo descifrado:	$plano";
                  mv $diredescifr$nombre $respaldoDesc;
                  rm $diredescifr$sig;
            fi
          fi
        done          
      fi
    fi
  exec 2>&1
	anio=$(date +"%Y")
	mes=$(date +"%m")
	dia=$(date +"%d")
	directorio_mueve=$anio"/"$mes"/"$dia
	mkdir -p $logDesc$directorio_mueve
	numero_archivos=($(find $logDesc -maxdepth 1 -type f  -iname "*.log"))
	if [ ${#numero_archivos[@]} -gt 0 ]; then  
		mv "${numero_archivos[@]}" $logDesc$directorio_mueve  
	else
		echo " No existe ningun archivo de log para clasificar."
	fi
}

descifrado_INBOX $1 $2 $3 $4