open(FH,"<misc.txt")||die;
print "<table><tr><th>misc</th><th>misc image</th><th>existing</th></tr>\n";
while(<FH>)
{
    chomp;
    my $path = $_;
    $path =~ s(^\.\/)();
    my ($dir, $fn) = split m(/), $path;
    if (-e("../$fn")) {
        print <<HTML;
<tr><td>$dir/$fn</td><td><img src="$dir/$fn"></td><td><img src="../$fn"></td></tr>
HTML
    }
}
print "</table>\n";
