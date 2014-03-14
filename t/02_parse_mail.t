use strict;
use warnings;
use Test::More;

use_ok 'Soffritto::Deploy';

{
    ok open my $fh, 't/sample.mime';
    my $deploy = Soffritto::Deploy->new;
    ok $deploy->parse_mail($fh);
    is $deploy->{home_input}, 'https://github.com/soffritto/Soffritto-Deploy';
    is $deploy->{branch}, 'master';
    ok $deploy->{from_github};
    ok $deploy->{has_commit};
}
{
    ok open my $fh, 't/boo.mime';
    my $deploy = Soffritto::Deploy->new;
    ok ! $deploy->parse_mail($fh);
    ok ! $deploy->{home_input};
    ok ! $deploy->{branch};
    ok ! $deploy->{from_github};
    ok ! $deploy->{has_commit};
}
{
    ok open my $fh, 't/from_ng.mime';
    my $deploy = Soffritto::Deploy->new;
    ok ! $deploy->parse_mail($fh);
    ok $deploy->{home_input};
    ok $deploy->{branch};
    ok ! $deploy->{from_github};
    ok $deploy->{has_commit};
}
{
    ok open my $fh, 't/delete_branch.mime';
    my $deploy = Soffritto::Deploy->new;
    ok ! $deploy->parse_mail($fh);
    is $deploy->{home_input}, 'https://github.com/soffritto/Soffritto-Deploy';
    is $deploy->{branch}, 'first_implementation';
    ok $deploy->{from_github};
    ok ! $deploy->{has_commit};
}

done_testing;
