SHORT_DATE=`echo $2 | sed -e 's/_//g'`

if [ -d "/RSS_ARCHIVE/re-outgoing/${1}/${2}" ]; then
  ERR="/RSS_ARCHIVE/re-outgoing/${1}/${2}"
  cat ${ERR}/RE_* > list.err
else
  ERR="/RSS_ARCHIVE/re-outgoing/${1}/local"
  cat ${ERR}/RE_* | grep ${SHORT_DATE} > list.err
fi

if [ -f "list.err" ]; then 
        ls /RSS_ARCHIVE/bis-incoming/${1}/${2}/${1}* > list.dir
fi


for f in `cat list.err`
do
FILE=`echo $f | cut -d, -f 1`
FNUM=`echo $f | cut -d, -f 2`
TYPE=`echo $f | cut -d, -f 3`
if [ "$TYPE" = "1" ]; then TYPE="01"; fi
if [ "$TYPE" = "3" ]; then TYPE="03"; fi
if [ "$TYPE" = "8" ]; then TYPE="08"; fi
if [ "$TYPE" = "9" ]; then TYPE="09"; fi
ERNO=`echo $f | cut -d, -f 4`

#if [ "$ERNO" != "801" ]; then 

        #src=`find /RSS_ARCHIVE/bis-incoming/${1}/${2} -name ${FILE} -print`
        src=`cat list.dir | grep ${FILE}`
        #echo $src
        if [ -f "${src}" ] ; then
                echo "ERROR: $FILE $TYPE $ERNO"
                grep -n "^$TYPE" ${src} | grep "^$FNUM:" 
        else
                echo "$FILE not found"
        fi
#fi
done
