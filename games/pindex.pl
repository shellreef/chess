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
    my ($full_filename) = $File::Find::name;
    my ($pgn);

    return if $filename !~ m/[.]pgn$/;

    $full_filename =~ s/^[.]\///;
    $pgn = Chess::PGN::Parse->new($filename);

    while ($pgn->read_game()) {
        my $offset = 0;
        my @moves = $pgn->moves();
        # TODO: get offset somehow??
        my @a = ($full_filename, $offset, $pgn->white(), $pgn->black(), $pgn->event(), $pgn->result(), "", scalar @moves);
        print join("\t", @a), "\n";
    }
}



