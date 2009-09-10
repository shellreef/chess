#!/usr/bin/perl
# Created:20090809
# By Jeff Connelly
#
# Create index of PGN games

use strict;
use warnings;

# install with: sudo cpan Chess::Pgn
use Chess::Pgn;

my $p = Chess::Pgn->new("historical/classics.pgn");
while ($p->ReadGame()) {
    my @a = ($p->white, $p->black);
    print join("\t", @a), "\n";
}
$p->quit();


