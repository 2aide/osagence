#!/bin/bash
##


###################################################################################################################################################
## Copyright (C) 2010 www.2aide.fr                                                                                                               ##
##                                                                                                                                               ##
## Ce programme est un logiciel libre, vous pouvez le redistribuer et / ou le modifier selon les termes de la Licence Publique Générale GNU      ##
## telle que publiée par la Free Software Foundation; soit la version 2 de la Licence, ou (à votre choix) toute version ultérieure.              ##
##                                                                                                                                               ##
## Ce programme est distribué dans l'espoir qu'il sera utile, mais SANS AUCUNE GARANTIE, sans même la garantie implicite de COMMERCIALISATION    ##
## ou D'ADAPTATION A UN USAGE PARTICULIER. Voir la Licence Publique Générale GNU, disponible ici http://www.opensource.org/licenses/gpl-2.0.php  ##
## pour plus de détails.                                                                                                                         ##
##                                                                                                                                               ##
## Vous devriez avoir reçu une copie de la Licence Publique Générale GNU avec ce programme, sinon, écrivez à                                     ##
## Free Software Foundation, Inc, 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA                                                          ##
##                                                                                                                                               ##
##                                                                                                                                               ##
##                                 En 2 mots, vous étes libre d'utiliser, de copier et de distribuer ce programme                                ##
##                                  à condition de soumettre votre copie à la même licence GPL v-2 ou ultérieure                                 ##
##                                                                                                                                               ##
###################################################################################################################################################

## On récupère les emplacements des répertoires de travail de OSagence
eval "$(grep 'rept1=\"' '/usr/share/osagence/osa-menu')"
eval $(grep 'rept=\"' "${rept1}/rept/rept.cfg")

## Boucle infinie pour relancer le script après chaque opération incompléte
while true
	do

		## On réinitialise les variables
		unset chauf1
		lign="0"
		## On récupère les lignes correspondantes au motif de recherche et on les inscrit dans une variable tableau
		for chauf in `cat "${rept}/conf/.chauffage.txt" | sed "s/ /_/g" | cut -d# -f2`; do
			chauf1[$lign]="FALSE ${chauf} "
			((lign++))
		done

		## Fenêtre de sélection du résultat
		chauffage=$(zenity --width=400 --height=800 --list --column "" --radiolist\
			--title="Choix du type de chauffage" \
			--text="Choisissez le chauffage utilisé." \
			--column="" \
			${chauf1[@]})
		
		if [ ! -z "${chauffage}" ]; then
					{
						break
					}
				fi
					
done
chauffage2=$(echo "${chauffage}" | sed "s/_/ /g")			
echo $(grep "#${chauffage2}#" "${rept}/conf/.chauffage.txt" | cut -d# -f3) > "${rept1}/chauffage.tmp" 

exit 0
