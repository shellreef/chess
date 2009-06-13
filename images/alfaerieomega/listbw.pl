#!/usr/bin/perl
# Created:20090612
# By Jeff Connelly
#
# Create comprehensive list of all pieces

opendir(DIR,".")||die;
open(MASTER,">master.html")||die;
open(LIST,">list.txt")||die;
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

print MASTER "<table>\n";
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
    print MASTER "<tr><td>$i</td>";
    #for my $color (qw(w b r g y l)) {
    for my $color (qw(w b)) {
        print MASTER "<td>";
        print MASTER "<img src=\"$color$name\">" if $colors{$color}{$name};
        print MASTER "</td>";
    }
    print MASTER "<td>$shortname</td></tr>\n";
    print LIST "$shortname\n";
}

print MASTER <<HTML;
</table>
HTML

close(MASTER);
close(LIST);
