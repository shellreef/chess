#!/usr/bin/perl
# Created:20090613
# By Jeff Connelly
#
# Lowercase piece image filenames
use File::Slurp qw/slurp/;

my @files=split("\n", slurp("list.txt"));

for my $file (@files)
{
    my $better = better($file);
    if ($better ne $file) {
        #die "conflict: $file -> $better, but $better exists" if lc($file) ne $better && -e($better);
        print "$file -> $better\n";
        $cmd = "mv w$file.gif w$better.gif";
        print "$cmd\n";
        system($cmd);
        $cmd = "mv b$file.gif b$better.gif";
        print "$cmd\n";
        system($cmd);

        $cmd = "perl -i.bak -pe's/\\Q$file\\E/$better/g' *.html *.txt";
        print "$cmd\n";
        system($cmd);
    }
}

sub better
{
    my ($in) = @_;
    my ($out);

    ($out = $in) =~ tr/A-Z-/a-z_/;
    return $out;
}

