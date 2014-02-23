package Soffritto::Deploy;
use strict;
use warnings;

our $VERSION = '0.01';

sub new {
    my ($class, %args) = @_;
    if (my $file = $args{config}) {
        my $config = do $file;
        if (ref($config) eq 'HASH') {
            for my $key (keys %$config) {
                $args{$key} = $config->{$key};
            }
        }
    }
    $args{git_path} ||= 'git';
    bless \%args, $class;
}

sub parse_mail {
    my ($self, $fh) = @_;

    if (! $fh) {
        $fh = $self->{fh} or return;
    }

    while (my $line = <$fh>) {
        if ($line =~ m{^From: GitHub <noreply\@github.com>}) {
            $self->{from_github} = 1;
        }
        if ($line =~ m{^\s+Home:\s+(https://github.com/\S+)$}) {
            $self->{repository} = $1;
        }
        if ($line =~ m{^\s+Branch:\s+(?:refs/heads/([^/\s]+))$}) {
            $self->{branch} = $1;
        }
    }
    return $self->{from_github} && $self->{repository} && $self->{branch};
}

sub deploy {
    my $self = shift;
    for (qw(deploy_to repository)) {
        $self->{$_} or die "$_ option required";
    }
    if (-d $self->{deploy_to}) {
        # ディレクトリがある。多分git fetchできる

    } else {
        # ディレクトリがない。多分git cloneする
    }
    1;
}

1;
