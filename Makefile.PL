use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME => 'deploy_by_mailhook',
    AUTHOR => 'Nobuo Danjou <danjou@soffritto.org>',
    VERSION_FROM => 'lib/Soffritto/Deploy.pm',
    PREREQ_PM => {
        'FindBin' => 0,
        'GetOpt::Long' => 0,
        'File::Basename' => 0,
        'Test::More' => 0,
    },
);
