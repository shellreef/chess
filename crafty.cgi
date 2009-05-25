#!/usr/bin/perl
# Created:200090524
# By Jeff Connelly
#
# Interface to the Crafty chess engine
use strict;
use warnings;

use CGI qw/:standard/;
use IPC::Open2;
use  JSON;  # http://search.cpan.org/dist/JSON/lib/JSON.pm

warn "crafty.pl @{[ scalar localtime ]} $ENV{REMOTE_ADDR}\n";

print header(-type => "application/json");;

my ($move, $score, $output, $error, $board);

$board = param("fen");
if (!$board) {
    $error = "No board given";
} else {
    if ($board !~ m(^([a-zA-Z0-9 /-]+)$)) {
        $error = "Illegal characters";
    }
    if ($board !~ m(^[rnbqkpRNBQKP0-9/]+ [wb] [KQkq-]+ [a-z0-9-]+ \d+ \d+)) {
        $error = "Invalid board";
    }
}

if (!$error) {
    ($move, $score, $output, $error) = compute($board);
}

warn "Error: $error\n" if defined($error);
warn "OK" if !defined($error);

print to_json({
    next_move => $move,
    score => $score,
    #output => $output,
    error => $error});

sub compute
{
    my ($board) = @_;
    my ($pid, $in, $out, $output, @cmds, $move, $score, $error);

    $|++;
    $pid = open2($out, $in, "/usr/local/bin/crafty");
    warn "Starting crafty: $pid\n";
    @cmds = (
        "smpmt 2",
        "alarm off",
        "st 1",
        "ponder off",

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

    warn "$output\n";

    if ($output =~ m/(illegal position.*)/) {
        $error = ucfirst($1);
    } elsif ($output =~ m/usage: /) {
        $error = "Bad usage";
    }

    # Move is highlighted with ANSI escape code in reverse video
    ($move) = $output =~ m/\c[[^:]+: (\S+)/;
    ($score) = $output =~ m/total[.]+\s*(\S+)/;

    $score += 0;

    $error = "Error reading output" if !$move || !$score;

    return ($move, $score, $output, $error);
}

sub fatal
{
    my ($msg) = @_;

    warn "Fatal error: $msg\n";

    exit;
}

