package AI::Dapper;

use 5.014002;
use strict;
use warnings;

use Lingua::EN::Tagger;

require Exporter;

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our @brain;

our $VERSION = '0.1';
our $NAME = 'AI::Dapper';

our $pov=0;
our $aud='';
our $aud_tagged='';

our $act='';
our $actbase=0;

our $cns=8; #size of memory channel
our $coda;

our $quiet=0;
our $residuum=0;

our $tagger;

our %chain;

our @nn;
our @jj;
our @in;

#bootstrap
sub boot
{
	$tagger = new Lingua::EN::Tagger;
}

#audition

sub textinput
{
	my $self = shift;
	my $text = shift;
	
	$aud_tagged = $self->tag($text);
	
	$aud = $text;
	$pov=1;
	
	$self->mainloop();
	
	return 1;
}

sub mainloop
{
	my $self = shift;
	
	if ($self->security())
	{
		$self->strap();
		$self->audition();
		$self->metacognition();
		$self->metamemory();
		$self->volition();
		$self->motor();
		$self->act();
	}
	
}

sub security
{
	my $self = shift;
	
	return 1;
}

sub strap
{
}

sub volition
{
}

sub motor
{
	return 0 if ($quiet);
}

sub act
{
	my %nouns=();
	my ($k,$v);
	
	foreach my $noun(@nn) { $nouns{$noun}++; }
	
	while ( ($k, $v) = each %nouns )	{ $actbase = $v if ($v>$actbase); }
	while ( ($k, $v) = each %nouns )	{ $act = $k if($v==$actbase); }
}

sub metacognition
{
	my $self = shift;
	
}

sub metamemory
{
	my $self = shift;
	
	# compensate for memory channel width
	if (@nn > $cns) { pop(@nn); $self->metamemory(); }
	if (@jj > ($cns / 2)) { pop(@jj); $self->metamemory(); }
	if (@in > ($cns / 4)) { pop(@in); $self->metamemory(); }

	my @words = split (/ /, $aud);
	my $i=0;
	
	foreach my $w(@words)
	{
		$i++;
		
		$chain{$w} = $words[$i] if ($words[$i]);
	}
}

sub tag
{
	my $self = shift;
	my $text = shift;
	
	return ($tagger->add_tags($text));
}

sub untag
{
	my $self = shift;
	my $text = shift;
	
	return ($tagger->remove_tags($text));
}

# returns array of nouns from tagged text

sub nouns { return @nn; }
sub adjectives { return @jj; }
sub prepositions { return @in; }

# returns array of adj from tagged text
sub audition
{
	my $self = shift;
	
	my @words = split(/ /, $aud_tagged);
	
	foreach my $word (@words)
	{
		push @nn, $1 if ($word =~ /\<nn\>(\S+)\<\/nn\>/);
		push @jj, $1 if ($word =~ /\<jj\>(\S+)\<\/jj\>/);
		push @in, $1 if ($word =~ /\<in\>(\S+)\<\/in\>/);

	}
	
	return 1;
}

# constructor
sub new { bless {}, shift; }

# methods
sub get_name
{
	my $self = shift;
	return ($NAME);
}

sub get_version
{
	my $self = shift;
	return ($VERSION);
}

1;
__END__

=head1 NAME

AI::Dapper - Perl extension for Dapper Mind Artificial Intelligence Applications

=head1 SYNOPSIS

  use AI::Dapper;

my $dapper = new AI::Dapper;

$dapper->textinput("hey whats up guys");

=head1 DESCRIPTION

AI::Dapper is the module and framework for creating the Dapper IRC bot

=head2 EXPORT

None by default.



=head1 SEE ALSO

This was created originally for an IRC bot based loosely on concepts behind AI Mind,

http://theinfinitynetwork.org/

=head1 AUTHOR

anonymous, E<lt>infn@theinfinitynetwork.org<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2013 by The Infinity Network (http://theinfinitynetwork.org/)

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.14.2 or,
at your option, any later version of Perl 5 you may have available.


=cut
