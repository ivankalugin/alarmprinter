#!/usr/bin/perl
#
# /usr/local/bin/alarmprinter.pl
#
# sudo perl -MCPAN -e 'install Bundle::DBI'
# sudo perl -MCPAN -e 'install DBD::Pg'
#
use IO::Socket::INET;
use DBI;
$printerport=12000;
$dbname = "intouch";
$username = "alarmprinter";
$password = "alarmprinter";
$dbhost = "localhost";
$dbport = "5432";
$pserve=IO::Socket::INET->new(LocalPort=>$printerport,Type=>SOCK_STREAM,Reuse=>1,Listen=>1) or die "can't do that $!\n";
while ($pjob=$pserve->accept()) {
    while (<$pjob>) {
	chop;
	$line = $_;
	$check = $line;
	$ok = $check =~ tr/;//;
	if ($ok >= 12)
	{
	    @value = split (/;/);
	    if ($value[0] ne 'Date')
	    {
		$value[0] =~ s/\//-/g;
		$value[1] = $value[0] . " " . $value[1];
		$value[0] = 'LOCALTIMESTAMP';
		$dbiPg = DBI->connect("DBI:Pg:dbname=$dbname;host=$dbhost;port=$dbport;","$username","$password",{ RaiseError => 1});
		$query = "INSERT INTO alarmprinter.alarmprinter(printerdt, alarmdt, state, class, type, priority, name, alarmgroup, provider, value, valuelimit, node, operator, comment) VALUES ($value[0],'$value[1]','$value[2]','$value[3]','$value[4]','$value[5]','$value[6]','$value[7]','$value[8]','$value[9]','$value[10]','$value[11]','$value[12]','$value[13]');";
		$result = $dbiPg->do($query);
		$dbiPg->disconnect();
	    }
	}
    }
    close $pjob;
}
