#!/bin/bash
echo ""
echo "Componente para Cifrado"
var_dia=`date +"%d/%m/%Y_%H:%M:%S"`
cifrado_OUTBOX(){

  #PARAMETRIA CIFRADO
  #-----------------------------------
  # direcifra="/home/master/outbox/"
  # pass_cif="/home/master/outbox/passphrase/pgpassC"
  # uid_public_BAZ="912DF6C3037470023429CE200A89738FF87B568B"
  # respaldoCif="/home/master/outbox/respaldoTXT/"
  # logCifr="/home/master/outbox/logsCifrado/"
  #-----------------------------------
  direcifra=$1
  pass_cif=$2
  uid_public_BAZ=$3
  respaldoCif=$4
  logCifr=$5

	cd $direcifra
	dia_actual=`date +"%d%m%Y_%H%M%S"`
	exec > >(tee -i $logCifr"`basename $0`_"$dia_actual".log" )
		echo "Proceso de Cifrado."
		echo "Fecha ejecucion: $var_dia"
		if [ ! -d $direcifra ]; then
			echo "El buzon OUTBOX no existe, favor de validar."
		else
			numero_archivos_txt=($(find $direcifra -maxdepth 1 -type f -iname "*.txt"))
			if [ ${#numero_archivos_txt[@]} -eq 0 ]
				then
				echo "No existen archivos para cifrar en el buzon OUTBOX."
			else
				echo "Numero de archivos para cifrar en el buzon OUTBOX: ${#numero_archivos_txt[@]}"
				echo "----------------------------------------------------------"
				for h in "${numero_archivos_txt[@]}"
				do
				nombre=$(basename "$h")
				echo "Archivo original: $nombre"
				gpg --batch --pinentry-mode loopback --passphrase-file $pass_cif --cipher-algo AES256 --force-mdc -o $nombre".sig" --sign $nombre
				sig=$nombre".sig"
				if [ ! -f $direcifra$sig ];
					then
						echo "Error al firmar digitalmente el archivo : "$sig
				else
					echo "Archivo firmado: "$sig
					gpg --cipher-algo AES256 --force-mdc -e -o $sig".pgp" -r $uid_public_BAZ $sig
					if [ ! -f $direcifra$sig".pgp" ];
						then
							echo "Error al cifrar el archivo: "$sig".pgp"
					else
						echo "Archivo cifrado: "$sig".pgp"
						rm $direcifra$sig
						mv $nombre $respaldoCif
					fi
				fi
				echo ""
				done
			fi
		fi
	exec 2>&1
	anio=$(date +"%Y")
	mes=$(date +"%m")
	dia=$(date +"%d")
	directorio_mueve=$anio"/"$mes"/"$dia
	mkdir -p $logCifr$directorio_mueve
	numero_archivos=($(find $logCifr -maxdepth 1 -type f -iname "*.log"))
	if [ ${#numero_archivos[@]} -gt 0 ]; then
		mv "${numero_archivos[@]}" $logCifr$directorio_mueve
	else
		echo " No existe ningun archivo de log para clasificar."
	fi
}

cifrado_OUTBOX $1 $2 $3 $4 $5