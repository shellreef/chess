opendir(DIR,".")||die;
my @files=readdir(DIR);
closedir(DIR);
my %whites, %blacks;
for my $file (@files)
{
    next if $file !~ m/^[bw]/ || $file !~ m/\.gif$/;

    if ($file =~ m/^w(.*)/) {
        $whites{$1} = 1;
    } elsif ($file =~ m/^b(.*)/) {
        $blacks{$1} = 1;
    } else {
        die "??? $file";
    }
}

print <<HTML;
<table><tr><th>#</th><th>white</th><th>black</th><th>name</th></tr>
HTML
my $i = 0;
for my $name (sort keys %whites)
{
    # Skip white pieces without corresponding black, currently:
    # wewall.gif
    # wforfnibakking.gif
    # wfurlrurlbakking.gif
    # wwwall.gif
    next if !$blacks{$name};

    my $shortname;
    ($shortname = $name) =~ s/\.gif//;
    $i += 1;
    print "<tr><td>$i</td><td><img src=\"w$name\"></td><td><img src=\"b$name\"></td><td>$shortname</td></tr>\n";
}

print <<HTML;
</table>
HTML
