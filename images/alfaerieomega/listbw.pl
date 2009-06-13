#!/usr/bin/perl
# Created:20090612
# By Jeff Connelly
#
# Create comprehensive list of all pieces

opendir(DIR,".")||die;
my @files=readdir(DIR);
closedir(DIR);
my %colors;
for my $file (@files)
{
    next if $file !~ m/\.gif$/;

    my $color = substr($file, 0, 1);
    my $key = substr($file, 1);

    $colors{$color}{$key} = 1;
}

print <<HTML;
<table><tr><th>#</th><th>white</th><th>blue</th><th>name</th></tr>
HTML
my $i = 0;
for my $name (sort keys %{$colors{w}})
{
    # Skip white pieces without corresponding black, currently:
    # wewall.gif
    # wforfnibakking.gif
    # wfurlrurlbakking.gif
    # wwwall.gif
    next if !$colors{b}{$name};

    my $shortname;
    ($shortname = $name) =~ s/\.gif//;
    $i += 1;
    print "<tr><td>$i</td><td><img src=\"w$name\"></td><td><img src=\"b$name\"></td><td>$shortname</td></tr>\n";
}

print <<HTML;
</table>
HTML
