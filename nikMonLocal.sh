#!/usr/bin/bash
for line in `cat $1` 
do
	dir=`echo $line | awk -F";" '{print$1}'`
	delay=`echo $line | awk -F";" '{print$2}'`
	count=`echo $line | awk -F";" '{print$3}'`
	perl ./get_dir_infoNike.pl $dir $delay $count
done
