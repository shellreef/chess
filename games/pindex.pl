#!/usr/bin/perl
# Created:20090809
# By Jeff Connelly
#
# Create index of PGN games

use strict;
use warnings;

use File::Find;

# install with: sudo cpan Chess::Pgn
use Chess::Pgn;

find(\&process_file, ".");

sub process_file
{
    my ($filename) = $_;
    my ($pgn);

    return if $filename !~ m/[.]pgn$/;

    print "$File::Find::name\n";
    $pgn = Chess::Pgn->new($filename);
    # Bug: hangs on ctew/2.1.queen-checkmate-position.pgn, which is a game with no moves (position only)
    while ($pgn->ReadGame()) {
        my @a = ($pgn->white, $pgn->black);
        print join("\t", @a), "\n";
    }
    $pgn->quit();
}



