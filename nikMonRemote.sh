(cat get_dir_infoNike.pl | ssh $1 "export PATH=\$PATH:/opt/perl/bin; perl - $2")
