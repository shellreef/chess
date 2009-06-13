open(FH,"<misc.txt")||die;
print "<table><tr><th>misc</th><th>misc image</th></tr>\n";
while(<FH>)
{
    chomp;
    my $path = $_;
    $path =~ s(^\.\/)();
    my @a = split m(/), $path;
    my $fn = pop @a;
    my $dir = join("/", @a);

    # skip dupes, handled by findexist.pl
    next if -e("../$fn");

    # not interested in flipped pieces: namespace conflict,
    # and could easily create programmatically
    next if $path =~ m(flip/);

    # nor small pieces, can easily create with <img> width & height
    next if $path =~ m(small/);

    print <<HTML;
<tr><td>$dir/$fn</td><td><img src="$dir/$fn"></tr>
HTML
}
print "</table>\n";
