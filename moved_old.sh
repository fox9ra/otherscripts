#!/usr/local/bin/bash

# script to moved old files for broker backup
#set -x

cd /RSS_BROKER/etc
ARCHIVE="/BROKER/NRIN/Archive/rss-broker/"
BACKUP="/BROKER/NRIN/NewArchive/BACKUP/"
#oBACKUP="/BROKER/NRIN/Archive/rss-broker/BACKUP/"
GZIP="/usr/contrib/bin/gzip"
#preparation date

#year=`date "+%Y"`
#month=`date "+%m"`

#year=2012
#month=01


if [ "$month" == "01" ]; then
newyear=`expr $year - 1`
newmonth="12"
elif [ "$month" == "12" ]; then
newyear="$year"
newmonth="11"
elif [ "$month" == "11" ]; then
newyear="$year"
newmonth="10"
else
newmonth1=`expr $month - 1`
newyear="$year"

newmonth=`echo "0"$newmonth1`

fi

#DTA=`echo $newyear"_"$newmonth`
#DTA=2016_07_18
DTA=`perl -MPOSIX -le 'print scalar strftime "%Y_%m_%d", localtime(time - 86400)'`


SHORT_DATE=`echo $DTA | sed 's/_//g'`

#Create dirs

for dir in bis-incoming brt-rss-outgoing rd-outgoing re-outgoing roam-incoming rss-outgoing apk-incoming apk-outgoing rw
-incoming ptpt-incoming


do
        if [ ! -d $BACKUP/$dir ]; then  
        mkdir $BACKUP/$dir                      
        echo "Created dir $BACKUP/$dir"
        fi

        
#Moving /RSS_ARCHIVE/dir/filial/date
        
        fil_arch() {                   
        for fil in `ls $ARCHIVE/$dir/ `
        do
                for dta in `ls $ARCHIVE/$dir/$fil/ | grep $DTA`
                do
                        if [ ! -d $BACKUP/$dir/$fil ]; then
                                mkdir $BACKUP/$dir/$fil
                        fi

                        echo "Moving $ARCHIVE/$dir/$fil/$dta to $BACKUP/$dir/$fil/$dta"
                        mv $ARCHIVE/$dir/$fil/$dta $BACKUP/$dir/$fil/$dta
                        $GZIP $BACKUP/$dir/$fil/$dta/*
                done
        done
}

#Moving /RSS_ARCHIVE/dir/date

dta_arch() {                          
        for dta in `ls $ARCHIVE/$dir/ | grep "^${DTA}"`
        do
                echo "Moving $ARCHIVE/$dir/$dta to $BACKUP/$dir/$dta"
                mv $ARCHIVE/$dir/$dta $BACKUP/$dir/$dta
                $GZIP $BACKUP/$dir/$dta/*
        done
}

rss-incoming() {                      #Moving /RSS_ARCHIVE/rss-incoming/RSS/
        if [ "$dir" == "rss-incoming" ]; then
                mkdir $BACKUP/$dir/RSS
                echo "Created dir $BACKUP/$dir/RSS"
                for dta in `ls $ARCHIVE/$dir/RSS/ | grep $DTA`
                do
                        echo "Moving $ARCHIVE/$dir/RSS/$dta to $BACKUP/$dir/RSS/$dta"
                        mv $ARCHIVE/$dir/RSS/$dta $BACKUP/$dir/RSS/$dta
                        $GZIP $BACKUP/$dir/RSS/$dta/*
                done 
                fi
                }

#Moving /RSS_ARCHIVE/re-outgoing/

re-outgoing() {                       
                for fil in `ls $ARCHIVE/$dir/`
        do
                if [ "$fil" == "RUSNW" ]; then
                    if [ ! -d $BACKUP/$dir/$fil ]; then
                                mkdir $BACKUP/$dir/$fil
                    fi
                        for file in `ls $ARCHIVE/$dir/$fil/local/*$SHORT_DATE*`
                        do
                        mv $file $BACKUP/$dir/$fil/
                        done
                        $GZIP $BACKUP/$dir/$fil/*
                else
                for dta in `ls $ARCHIVE/$dir/$fil/ | grep $DTA`
                do
                        if [ ! -d $BACKUP/$dir/$fil ]; then
                                mkdir $BACKUP/$dir/$fil
                        fi

                        echo "Moving $ARCHIVE/$dir/$fil/$dta to $BACKUP/$dir/$fil/$dta"
                        mv $ARCHIVE/$dir/$fil/$dta $BACKUP/$dir/$fil/$dta
                        $GZIP $BACKUP/$dir/$fil/$dta/*
                done
                fi
        done
}

case $dir in
        'bis-incoming')
        fil_arch
        ;;
        'brt-rss-outgoing')
        dta_arch
        ;;
        'rd-outgoing')
        fil_arch
        ;;
        're-outgoing')
        re-outgoing
        ;;
        'roam-incoming')
        fil_arch
        ;;
        'rss-outgoing')
        fil_arch
        ;;
        'apk-incoming')
        dta_arch
        ;;
        'apk-outgoing')
        fil_arch
        ;;
        'rw-incoming')
        dta_arch
        ;;
        'ptpt-incoming')
        fil_arch
        ;;
esac

done
