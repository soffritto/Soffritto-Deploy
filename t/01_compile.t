use strict;
use warnings;
use Test::More;

ok my $str = `cat t/sample.mime | perl deploy.pl`;
like $str => qr{https://github.com/soffritto/deploy_by_mailhook};

done_testing;
