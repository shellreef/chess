#!/usr/bin/perl
# Created:200090524
# By Jeff Connelly
#
# Interface to the Crafty chess engine
use strict;
use warnings;

use IPC::Open2;

my ($pid, $in, $out, $output, @cmds, $move, $score, $board);
    
$board = "rnbqkbnr/pp1pp3/8/1p3ppp/8/PP2P3/2PP1PPP/R1BQKBNR w KQkq - 0 6";

if ($board !~ m(^([a-zA-Z0-9 /-]+)$)) {
    die "Illegal characters\n";
}
if ($board !~ m(^[rnbqkpRNBQKP0-9/]+ [wb] [KQkq-]+ [a-z0-9-]+ \d+ \d+)) {
    die "Invalid board\n";
}

$|++;
$pid = open2($out, $in, "crafty");
print "$pid\n";
@cmds = (
    "setboard $board",
    "go",
    "score",
    "end");
for my $cmd (@cmds)
{
    print $in "$cmd\n";
}
{
    local $/;
    $output = <$out>;
}

print "$output\n";

if ($output =~ m/Illegal position/) {
    die "Illegal position\n";
}

# Move is highlighted with ANSI escape code in reverse video
($move) = $output =~ m/\c[[^:]+: (\S+)/;
($score) = $output =~ m/total[.]+\s*(\S+)/;

print "|$move|\n";
print "|$score|\n";

