open(FH,"<misc.txt")||die;
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

    my @cmd = ("cp", "-i", $path, "../$fn");
    system(@cmd);
}
