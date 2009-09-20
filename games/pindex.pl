#!/usr/bin/perl
# Created:20090809
# By Jeff Connelly
#
# Create index of PGN games

use strict;
use warnings;

use File::Find;
use Data::Dumper;
use POSIX qw(ceil);

# install with: sudo cpan Chess::PGN::Parse
use Chess::PGN::Parse;

# sudo cpan JSON
use JSON;

our (@result, $id);
$id = 0;

find(\&process_file, ".");

print to_json([reverse @result]), "\n";

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
        $pgn->parse_game(); # parses moves
        my $moves = $pgn->moves();
        my %h = %{$pgn->tags()};
        $h{Filename} = $full_filename;
        $h{Offset} = $offset;   # TODO: get offset somehow??
        $h{PlyCount} ||= scalar @$moves;
        $h{MoveCount} = ceil($h{PlyCount} / 2);
        $h{SmallResult} = ($h{Result} eq "1/2-1/2" ? "1/2" : $h{Result}), 
        $h{OpeningName} = ""; # TODO: scid.eco

        if ($h{FEN} && $h{FEN} ne "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq -") {
            # FIDE Chess
            $h{OpeningMoves} = $h{Game};
        } else {
            # Non-standard startup position, so opening moves wouldn't be very useful.
            $h{OpeningMoves} = "pos";
        }

        $count += 1;
        push @games, {%h};
    }

    if (@games == 1) {
        # TODO: print all games. we only print one now, since load_pgn parses all.
       
        $id += 1;
        $games[0]{id} = $id;
        push @result, $games[0];
    }
}



