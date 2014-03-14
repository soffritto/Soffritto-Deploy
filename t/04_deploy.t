use strict;
use warnings;
use Test::More;
use File::Temp;
use_ok 'Soffritto::Deploy';

my $dir = File::Temp->newdir(CLEANUP => 0);
my $dirname = $dir->{DIRNAME} . '/Soffritto-Deploy';
my $out = "$dirname/foo";

ok my $deploy = Soffritto::Deploy->new(
    deploy_to => $dirname,
    after_deploy => "echo foo > $out",
    home => 'https://github.com/soffritto/Soffritto-Deploy',
);
open my $mime, '<', 't/sample.mime';
ok $deploy->parse_mail($mime);
ok $deploy->deploy;
ok -d $dirname;
ok $deploy->deploy;
ok open my $fh, '<', $out;
is do {local $/; <$fh>}, "foo\n";

done_testing;
