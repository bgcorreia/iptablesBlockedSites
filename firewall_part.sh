#!/bin/bash

# ESSA PARTE ENCAIXA NO SCRIPT DE FIREWALL, NA AREA PERTINENTE

	PAGS_BLOQUEADOS=( 1 2 3 5 6 7 9 10 11 12 13 14 15 16 17 )

	EXCECOES=( "192.168.111.14" "192.168.111.37" )

	SITES_BLOQUEADOS=( "facebook.com" "youtube.com" "suamusica.com" "assis.com" "netflix.com" "xvideos.com" "pornhub.com" "redtube.com")

	SITES_LIBERADOS=( "facebook.com" "youtube.com" )

	# ADICIONA REGRAS DE BLOQUEIO

	for i in "${PAGS_BLOQUEADOS[@]}"; do

		for j in 1 2 3 4 ; do

			for k in "${SITES_BLOQUEADOS[@]}"; do

				iptables -I FORWARD -p tcp -s 192.168.${i}${j}.0/24 -m string --algo bm --string "${k}" -j REJECT --reject-with tcp-reset

			done

		done

	done

	# ADICIONA REGRAS DE EXCECAO

	for i in "${EXCECOES[@]}"; do

		for j in "${SITES_LIBERADOS[@]}"; do

			iptables -I FORWARD -p tcp -s ${i}/32 -m string --algo bm --string "${j}" -j ACCEPT
		done

	done
