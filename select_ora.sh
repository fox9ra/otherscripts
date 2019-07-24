cd /pcef/lccn/instantclient_12_1

DTA=${1}

if [ -z "$DTA" ]
   then
   echo "./select.sh DD.MM.YY"
else

DTANAME=`echo $DTA | awk -F. 's=($1-1) {print s$2"20"$3}'`

echo "set heading off
set termout off
set linesize 1000
set trimspool on
set trimout on
set pagesize 0
set feedback off


spool /pcef/lccn/lccn_d_off.txt
select to_char(t.start_date,'DD.MM.YYYY')|| ';' ||t.num|| ';' ||t.lac|| ';' ||t.cell|| ';' ||t.succ_calls|| ';' ||t.zero
_calls|| ';' ||t.drop_calls from dal.V_S_QCD_LCCN_DAY t where trunc(t.start_date + 1) = '"$DTA"';
spool off;
exit;" > /pcef/lccn/instantclient_12_1/lccn_date.sql


./sqlplus '*******/********@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(HOST=*******)(PORT=15
21)))(CONNECT_DATA=(SID=oss)))' @lccn_date.sql

fi

DTA=`head -1 /pcef/lccn/lccn_d_off.txt | awk -F";" '{print$1}' | sed 's/\.//g'`
gzip -9 /pcef/lccn/lccn_d_off.txt
mv /pcef/lccn/lccn_d_off.txt.gz /pcef/lccn/lccn/lccn_d_"$DTA".gz
