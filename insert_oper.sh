DTA=`date '+%d%m%y'`
count=6
TIMELIMIT=10
echo "Enter IMSI:"
read  IMSI

if [ -z "$IMSI" ]
then
        echo "Out of time."
        else

                echo "Enter TAP:"
                read  TAP

                if [ -z "$TAP" ]
                then
                echo "Out of time."
                else
                
                count_imsi=`echo $IMSI | wc -c`
                count_tap=`echo $TAP | wc -c`

                if [ $count_imsi = $count ]
                then
                        if [ $count_tap = $count ]
                        then
                echo "insert into ROAM_TAPCODE (ID,FIRST_IMSI,LAST_IMSI,TAPCODE) values (${DTA},${IMSI}0000000000,${IMSI
}9999999999,'${TAP}');commit work;" | /RSS_BROKER/etc/db.sh
                echo "insert into REF.ROAM_TAPCODE (ID,FIRST_IMSI,LAST_IMSI,TAPCODE) values (${DTA},${IMSI}0000000000,${
IMSI}9999999999,'${TAP}');commit work;" | /usr/local/mysql/bin/mysql --host xx.xx.xx.xx
                echo "Oper IMSI = $IMSI; TAP = $TAP succesful added:"
                echo "In SOLID" 
                echo "select * from roam_tapcode where TAPCODE='${TAP}';" | /RSS_BROKER/etc/db.sh x
                echo "In MySQL" 
                echo "select * from REF.roam_tapcode where TAPCODE='${TAP}';" | /usr/local/mysql/bin/mysql --host xx.xx.xx.xx 
                
                        else 
                        echo "Error in TAP: $TAP must be 5 digits."
                        fi
                else
                echo "Error in IMSI: $IMSI must be 5 digits."
                fi
                fi    
fi  

    exit 0



#IMSI=${1}
#TAP=${2}
#echo "insert into ROAM_TAPCODE (ID,FIRST_IMSI,LAST_IMSI,TAPCODE) values (${DTA},${IMSI}0000000000,${IMSI}9999999999,'${
TAP}');commit work;"
