open(FH,"<misc.txt")||die;
print "<table><tr><th>misc</th><th>misc image</th></tr>\n";
while(<FH>)
{
    chomp;
    my $path = $_;
    $path =~ s(^\.\/)();
    my @a = split m(/), $path;
    my $fn = pop @a;
    my $dir = join("\n", @a);
    if (!-e("../$fn")) {
        print <<HTML;
<tr><td>$dir/$fn</td><td><img src="$dir/$fn"></tr>
HTML
    }
}
print "</table>\n";
