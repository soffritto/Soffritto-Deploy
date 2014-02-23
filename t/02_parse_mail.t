use strict;
use warnings;
use Test::More;

use_ok 'Soffritto::Deploy';

{
    ok open my $fh, 't/sample.mime';
    my $deploy = Soffritto::Deploy->new;
    ok $deploy->parse_mail($fh);
    is $deploy->{repository}, 'https://github.com/soffritto/deploy_by_mailhook';
    is $deploy->{branch}, 'first_implementation';
    ok $deploy->{from_github};
}
{
    ok open my $fh, 't/boo.mime';
    my $deploy = Soffritto::Deploy->new;
    ok ! $deploy->parse_mail($fh);
    ok ! $deploy->{repository};
    ok ! $deploy->{branch};
    ok ! $deploy->{from_github};
}
{
    ok open my $fh, 't/from_ng.mime';
    my $deploy = Soffritto::Deploy->new;
    ok ! $deploy->parse_mail($fh);
    ok $deploy->{repository};
    ok $deploy->{branch};
    ok ! $deploy->{from_github};
}

done_testing;
