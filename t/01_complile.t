use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok 'Soffritto::Deploy';
}

ok my $obj = Soffritto::Deploy->new;
isa_ok $obj, 'Soffritto::Deploy';

done_testing;
