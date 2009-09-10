#!/usr/bin/perl
# Created:20090809
# By Jeff Connelly
#
# Create index of PGN games

use strict;
use warnings;

use File::Find;

# install with: sudo cpan Chess::PGN::Parse
use Chess::PGN::Parse;

find(\&process_file, ".");

sub process_file
{
    my ($filename) = $_;
    my ($pgn);

    return if $filename !~ m/[.]pgn$/;

    print "$File::Find::name\n";
    $pgn = Chess::PGN::Parse->new($filename);

    while ($pgn->read_game()) {
        my @a = ($pgn->white, $pgn->black);
        print join("\t", @a), "\n";
    }
}



