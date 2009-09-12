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

# sudo cpan JSON
use JSON;

our (@result, $id);
$id = 0;

find(\&process_file, ".");

print to_json(\@result), "\n";

sub process_file
{
    my ($filename) = $_;
    my ($full_filename) = $File::Find::name;
    my ($pgn, $count, @games);

    return if $filename !~ m/[.]pgn$/;

    $full_filename =~ s/^[.]\///;
    $pgn = Chess::PGN::Parse->new($filename);

    while ($pgn->read_game()) {
        my $offset = 0;
        my @moves = $pgn->moves();
        # TODO: get offset somehow??
        my %h = (
            filename => $full_filename, 
            offset => $offset, 
            white => $pgn->white(), 
            black => $pgn->black(), 
            event => $pgn->event(), 
            result => ($pgn->result() eq "1/2-1/2" ? "1/2" : $pgn->result()), 
            opening => "",   # TODO
            size => scalar @moves);
    
        $count += 1;
        push @games, \%h;
    }

    if (@games == 1) {
        # TODO: print all games. we only print one now, since load_pgn parses all.
       
        $id += 1;
        $games[0]{id} = $id;
        push @result, $games[0];
    }
}



