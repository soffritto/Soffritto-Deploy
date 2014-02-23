use strict;
use warnings;
use Test::More;
use File::Temp;
use_ok 'Soffritto::Deploy';

my $dir = File::Temp->newdir(CLEANUP => 0);
my $dirname = $dir->{DIRNAME} . '/Soffritto-Deploy';

ok my $deploy = Soffritto::Deploy->new(
    deploy_to => $dirname,
    home => 'https://github.com/soffritto/Soffritto-Deploy',
);
open my $fh, 't/sample.mime';
ok $deploy->parse_mail($fh);
ok $deploy->deploy;
ok -d $dirname;
ok $deploy->deploy;

done_testing;
