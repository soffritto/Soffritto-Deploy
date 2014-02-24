#!/usr/bin/perl
use strict;
use warnings;
use FindBin;
use lib $FindBin::RealBin .'/lib';
use Soffritto::Deploy;
use Getopt::Long;

my %opt;
GetOptions(
    \%opt,
    'config=s',
    'repository=s',
    'deploy_to=s',
);

my $deploy = Soffritto::Deploy->new(%opt);
if ($deploy->parse_mail(\*STDIN)) {
    $deploy->to_tasks;
} else {
    die "NG";
}

=head1 NAME

deploy_by_mailhook

=head1 SYNOPSIS

foobar

=head1 AUTHOR

Nobuo Danjou E<lt>danjou@soffritto.orgE<gt>

=cut
