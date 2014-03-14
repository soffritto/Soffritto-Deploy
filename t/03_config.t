use strict;
use warnings;
use Test::More;
use_ok 'Soffritto::Deploy';

ok my $deploy = Soffritto::Deploy->new(
    config => 't/config_sample.pl',
);
is $deploy->{home}, 'https://github.com/soffritto/Soffritto-Deploy';
is $deploy->{git_path}, 'git';

done_testing;
