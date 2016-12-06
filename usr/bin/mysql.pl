#!/usr/bin/perl
use strict;
use warnings;
use DBI;

my $database = 'livestock';
my $username = 'root';
my $password = 'letmein';

my $dbh = DBI->connect("DBI:mysql:$database", $username, $password
	           ) || die "Could not connect to database: $DBI::errstr";


my $sth = $dbh->prepare('select a.type, a.name, a.gender, a.weight, b.price, b.price * a.weight AS value from livestock a, market b where a.type = b.type order by value desc');

$sth->execute();

printf "%-10s %-14s %-10s %14s %7s %s\n",'Type','Name','Gender','Weight','Price','Value';
print "--------------------------------------------------------------------\n";
my $rows = $sth->rows();

for (my $i = 0; $i < $rows ; $i++) 
{
  my  ($type,$name,$gender,$weight,$price,$value) = $sth->fetchrow_array();
	printf "%-10s %-14s %-10s %10slbs \$%.2f\\lb \$%.2f\n",$type,$name,$gender,$weight,$price,$value;
}
