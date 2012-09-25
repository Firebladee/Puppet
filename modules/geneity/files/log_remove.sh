#!/bin/bash

loc="/app/geneity/logs"
newloc="/app/logs"
ROOT_UID=0
E_XCD=86
E_NOTROOT=87

# Run as root
if [ "$UID" -ne "$ROOT_UID" ]
then
	echo "Must be root to run"
	exit $E_NOTROOT
fi

cd $loc || {
	echo "Cannot change to $loc, trying $newloc " >&2
#	exit $E_XCD;
	cd $newloc || {
                echo "Cannot change to $loc or $newloc " >&2
                exit $E_XCD;
        }
	loc=$newloc
}

du -c --max-depth=1 | while read size filename
do

	filename=`echo $filename | sed 's/^..//'`
	if [ ${size} -gt 1024000 ]
	then
#		echo $size $filename
#		cd $1/$filename && ls -tr | head -n 1 | xargs rm -i; 
		if [ "$filename" = "." ]
		then
			break
		fi
		cd $loc/$filename && rm -f `ls -tr | head -n 1`
	fi
done
