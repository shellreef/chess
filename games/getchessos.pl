#!/usr/bin/perl
# Created:20090809
# By Jeff Connelly
#
# Download ChessOS games
use strict;
use warnings;

while(<>)
{
    chomp;

    if (m/(\d{5})/) {
        my $no = $1;

        download_game($no);
    }
}

sub download_game
{
    my ($no) = @_;
    my ($no6) = sprintf "%.6d", $no;

    my $cmd = "curl -o game_$no6.pgn 'http://www.chessos.com/p/?m=download&dlid=$no&filename=game_$no6.pgn'";
    print "$cmd\n";
    system($cmd);
}
