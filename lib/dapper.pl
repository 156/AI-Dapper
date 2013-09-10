#!/usr/bin/perl

require AI::Dapper;

my $dapper = new AI::Dapper;

$dapper->boot();

while (<STDIN>)
{
	chomp;
	
	$dapper->textinput($_);

	foreach my $noun($dapper->nouns()) { print "noun: $noun\n";  }
	foreach my $adj($dapper->adjectives()) {	print "adjective: $adj\n"; }
	foreach my $prep($dapper->prepositions()) { print "preposition: $prep\n"; }

}