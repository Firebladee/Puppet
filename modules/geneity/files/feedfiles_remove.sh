#!/bin/bash

oldloc="/app/geneity/feedfiles"
ROOT_UID=0
E_XCD=86
E_NOTROOT=87

# Run as root
if [ "$UID" -ne "$ROOT_UID" ]
then
	echo "Must be root to run"
	exit $E_NOTROOT
fi

cd $oldloc || {
	echo "Cannot change to $oldloc " >&2
                exit $E_XCD;
        }

find . -maxdepth 1 -type d -regex '\./.*' | while read loc1
do
#	echo "first loop"
	cd $loc1 || {
		echo "Cannot change to $loc1 " >&2
		exit $E_XCD;
	}
#	echo $loc1

	du -c --max-depth=1 | while read size filename
	do
#		echo "first du loop"
		filename=`echo $filename | sed 's/^..//'`
		if [ "$filename" = "." ]
		then
			break
		fi
#		echo $size $loc1/$filename
		if [ ${size} -gt 1024000 ]
		then
#			echo "bigger than 1GB loop"
#			echo "where "
#			pwd
			cd $filename || {
				echo "Cannot change to $filename " >&2
				exit $E_XCD;
			}
#			ls -tr | head -n 1
			rm -rf `ls -tr | head -n 1`
			cd $oldloc/$loc1 || {
                                echo "Cannot change to $oldloc/$loc1 " >&2
                                exit $E_XCD;
                        }

		fi
	done
#	pwd
	cd $oldloc 
done
