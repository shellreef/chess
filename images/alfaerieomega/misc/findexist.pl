use File::Slurp qw/slurp/;

open(FH,"<misc.txt")||die;
print "<table><tr><th>misc</th><th>misc image</th><th>existing</th></tr>\n";
while(<FH>)
{
    chomp;
    my $path = $_;
    $path =~ s(^\.\/)();
    my @a = split m(/), $path;
    my $fn = pop @a;
    my $dir = join("/", @a);

    $fn = lc($fn);
    my $existing = "../$fn";

    $info = "";

    if (-e($existing)) {
        print <<HTML;
<tr><td>$dir/$fn</td><td><img src="$dir/$fn"></td><td><img src="../$fn"></td><td>$info</td></tr>
HTML
    }
}
print "</table>\n";

# Return whether two files are identical
# Not used, since none were exactly byte-wise equal
sub same
{
    my ($p1, $p2) = @_;

    return -s($p1) == -s($p2) && slurp($p1) eq slurp($p2);
}

