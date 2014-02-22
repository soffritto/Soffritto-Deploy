#!/usr/bin/perl
use strict;
use warnings;

our $VERSION='0.01';

my $mail = '';

while (<STDIN>) {
    $mail .= $_;
}

=head1 NAME

deploy_by_mailhook

=head1 SYNOPSIS

foobar

=head1 AUTHOR

Nobuo Danjou E<lt>danjou@soffritto.orgE<gt>

=cut
