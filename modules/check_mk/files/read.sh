#!/bin/bash

shopt -s nullglob

for file in *
do

#echo $file

touch /etc/check_mk/auto/mark

cat /etc/check_mk/main.mk | while read line
do
#	echo "$line"
#	echo ${line::9}
	if [[ ${line::9} =~ "all_hosts" ]]
	then
		if [[ "$line" =~ "$file" ]]
		then
			echo "$line" >> /etc/check_mk/auto/mark
			continue
		fi	
		echo ${line/]/", '$file' ]"} >> /etc/check_mk/auto/mark
	else
		echo "$line" >> /etc/check_mk/auto/mark
	fi
done

mv -uf /etc/check_mk/auto/mark /etc/check_mk/main.mk
#rm /etc/check_mk/agents/$file

done

check_mk -I
check_mk -O
