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

our $cns=8; #size of memory channel
our $coda;

our $quiet=0;
our $residuum=0;
our $rjc;

our $tagger;

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
	
	$self->audition();
	$self->metacognition();
	$self->metamemory();
	
	return 1;
}

sub metacognition
{
	my $self = shift;
	
}

sub metamemory
{
	my $self = shift;
	
	if (@nn > $cns) { pop(@nn); }
	if (@jj > ($cns / 2)) { pop(@jj); }
	if (@in > ($cns / 4)) { pop(@in); }

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

sub rejuvenate
{
	my $self = shift;
	
	@nn = ();
	@jj = ();
	@in = ();
	
	$rjc++;
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
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

AI::Dapper - Perl extension for blah blah blah

=head1 SYNOPSIS

  use AI::Dapper;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for AI::Dapper, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

am toor, E<lt>chao@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2013 by am toor

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.14.2 or,
at your option, any later version of Perl 5 you may have available.


=cut
