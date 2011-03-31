#!/bin/sh
TMP_FILE="/tmp/ssss"

rm -rf ${TMP_FILE}

declare -a LIST
MENU_ITEMS=""
count=0
# LINE is hostname
for LINE in `cat ssh_host.txt | awk '{print $2}'`; do
	LIST[$count]=$LINE
	MENU_ITEMS="${MENU_ITEMS} ${count} $LINE"
	((count++))
done

echo $MENU_ITEMS
#dialog --ascii-lines --menu "Zz SSH Connection Tool" 30 50 30 $(cat ssh_host.txt | tr '\n' ' ') 2> TMP_FILE
dialog --ascii-lines --menu "Zz SSH Connection Tool" 30 50 30 ${MENU_ITEMS} 2> ${TMP_FILE}

CHOOSE=`cat ${TMP_FILE}`

#Set terminal name (work in screen)
#Put the echo behind the ssh avoding the ssh failed but change screen title
ssh -l zz_chen ${LIST[$CHOOSE]} && echo -e "\033k${LIST[$CHOOSE]}\033\\"


