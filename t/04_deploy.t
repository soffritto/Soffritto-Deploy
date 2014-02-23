use strict;
use warnings;
use Test::More;
use File::Temp;
use_ok 'Soffritto::Deploy';

my $dir = File::Temp->newdir(CLEANUP => 1);

ok my $deploy = Soffritto::Deploy->new(
    deploy_to => $dir,
    repository => 'https://github.com/soffritto/Soffritto-Deploy',
);
open my $fh, 't/sample.mime';
ok $deploy->parse_mail($fh);
ok $deploy->deploy;

done_testing;
