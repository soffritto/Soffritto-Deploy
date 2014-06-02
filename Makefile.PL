use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME => 'deploy_by_mailhook',
    AUTHOR => 'Nobuo Danjou <danjou@soffritto.org>',
    VERSION_FROM => 'lib/Soffritto/Deploy.pm',
);
