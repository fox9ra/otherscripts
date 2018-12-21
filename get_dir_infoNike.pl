#!/usr/bin/perl  -w
use Time::Local;
use Term::ANSIColor;

get_info_dir($ARGV[0]);

sub get_info_dir {
my $dir=shift;#'/home/svn/tmp/ium/tmp_rec_type';
my $protocol=shift; #'local';
my $mask=shift;
my $size_v='Mb';

#----------------------------
$protocol||='local';
$mask||='.';
$size_v||='Mb';
#--
my $min_time_file=0;
my $max_time_file=10000;
my $dir_size=0;
my $cnt_file=0;
my $file_name='';
#delay in seconds
$delay=($ARGV[1]);
if (defined $delay)
{
	$max_delay=$delay; 
} else {
	$max_delay=3600;
}
#count files
$countfiles=($ARGV[2]);
if (defined $countfiles)
{
	$max_files=$countfiles; 
} else {
	$max_files=1000;
}

#----------------------------

if ($protocol eq 'local') # dir on localhost
{
   opendir(DIR,$dir) || ret_error("$dir ERROR opendir on localhost $!"); 
   #print($dir,"\n");
   while ($file_name=readdir(DIR)){
       if ((-f $dir.'/'.$file_name)&&($file_name=~ /$mask/)) {
            $cnt_file++;
            $dir_size+=-s $dir.'/'.$file_name;
            my $mday=-M $dir.'/'.$file_name;
            $min_time_file=($min_time_file<$mday?$mday:$min_time_file);
            $max_time_file=($max_time_file>$mday?$mday:$max_time_file);
			
       }
   }
   closedir(DIR) || ret_error("$dir ERROR closedir on localhost $!");
}
else {print "unknow place for dir $dir\n";}

#convert dirsize
my $k=0;
if ($size_v eq 'kb') {$k=1}
elsif ($size_v eq 'Mb') {$k=2}
elsif ($size_v eq 'Gb') {$k=3}
$dir_size=sprintf "%.2f $size_v",$dir_size/1024**$k;

#convert datatime
$min_file_delay=60*60*24*$min_time_file;
$max_time_file=0 if $max_time_file==10000;
my $alert='OK';
#$alert='WARN' if $min_time_file>1/24;
$alert='WARNCOUNT' if $cnt_file>$max_files;
$alert='WARNDELAY' if $min_file_delay>$max_delay;

$min_time_file=get_date_day($min_time_file);
$max_time_file=get_date_day($max_time_file);

if ($alert eq 'WARNDELAY') {
	print colored(sprintf("%s lvl:%s OLD_FILE cnt:%d sz:%s min:%s old_delay:%s max:%s\n",$dir,$alert,$cnt_file,$dir_size,$min_time_file,$min_file_delay,$max_time_file),'red');
} elsif ($alert eq 'WARNCOUNT') {
	print colored(sprintf("%s lvl:%s MANY_FILES cnt:%d sz:%s min:%s old_delay:%s max:%s\n",$dir,$alert,$cnt_file,$dir_size,$min_time_file,$min_file_delay,$max_time_file),'red');
} else {
	print "$dir lvl:$alert cnt:$cnt_file sz:$dir_size min:$min_time_file old_delay:$min_file_delay max:$max_time_file\n";
}
#return $cnt_file,$dir_size,$min_time_file,$max_time_file,$alert;


#--------------------------------------------------------
sub ret_error {
my $err_txt=shift;
$err_txt||='unknow error';
#print $err_txt,"\n";
print colored(sprintf("%s\n",$err_txt),'red');
#write_log(2,$err_txt); 
die;
}
#
sub get_date_day {
my $dday=shift;
use Time::Local;
my ($sec,$min,$hours,$mday,$mon,$year) = localtime(timelocal(localtime())-60*60*24*$dday);
$mon+=1;
$year+=1900;
$mon='0'.$mon if $mon<10;
$mday='0'.$mday if $mday<10;
$hours='0'.$hours if $hours<10;
$min='0'.$min if $min<10;
$sec='0'.$sec if $sec<10;
#return  "$year$mon$mday$hours$min$sec"; 
return  "$mday.$mon.$year $hours:$min:$sec";
}
}
