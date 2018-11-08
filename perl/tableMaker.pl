use DBI;
use strict;

#Database connection
my $dbh = DBI-> connect(
	"dbi:SQLite:dbname=roster.sqlite",
	"",
	"",
	{
		RaiseError => 1,
		AutoCommit => 0
	})
	or die "Database Connection failed" . DBI->errstr;

#Drop to prevent double population
	$dbh->do("DROP TABLE IF EXISTS roster");

#Table creation
my $rosterTable = qq(
	CREATE TABLE roster(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	first_name CHAR(100) NOT NULL,
	last_name CHAR(100),
	home CHAR(100) NOT NULL
	);
);
my $rv = $dbh->do($rosterTable);
if ($rv<0) {print DBI ->errstr;}

#Seed data
my $rosterInsert = qq(
	INSERT INTO rosterTable
		(first_name, last_name, home)
		VALUES
		("Rose", "Tyler", "Earth"),
		("Zoe", "Heriot", "Space Station W3"),
		("Jo", "Grant", "Earth"),
		("Leela", "", "Unspecified"),
		("Romana", "", "Gallifrey"),
		("Clara", "Oswald", "Earth"),
		("Adric", "", "Alzarius"),
		("Susan", "Foreman", "Gallifrey");
	);
$rv = $dbh->do($rosterInsert);
if ($rv<0) {print DBI ->errstr;}

#Query database
my $queryRoster = qq(SELECT * FROM rosterTable;);
$sth = $dbh->prepare($queryRoster) or die "Error in checking database" . $dbh->errstr;
$rv = $sth->execute() or die "Query failed" . $dbh->errstr;

#print database
while(my @row =$sth-> fetchrow_array()){
	print "ID: " . $row[0] . "\n";
	print "First Name: " . $row[1] . "\n";
	print "Last Name: " . $row[2]  . "\n";
	print "Home: " . $row[3] . "\n";
	print "===============================\n";
	print "Finished!\n"
}

$dbh->disconnect();