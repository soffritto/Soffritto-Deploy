package Soffritto::Deploy;
use strict;
use warnings;
use File::Basename;

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
    $args{github_type} ||= 'ssh';
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
            $self->{home_input} = $1;
        }
        if ($line =~ m{^\s+Branch:\s+(?:refs/heads/([^/\s]+))$}) {
            $self->{branch} = $1;
        }
    }
    return $self->{from_github} && $self->{home_input} && $self->{branch};
}

sub repo {
    my $self = shift;
    my $home = $self->{home} or return;
#    if ($self->{github_type} eq 'subversion') { return $home; }
    if ($self->{github_type} eq 'https') { return "$home.git"; }
    if ($self->{github_type} eq 'ssh') {
        my ($user, $repo) = $home =~ m{^https://github.com/([^\/]+)/([^\/]+)/?$};
        return "git\@github.com:$user/$repo.git";
    } 
}

sub deploy {
    my $self = shift;
    for (qw(deploy_to home)) {
        $self->{$_} or die "$_ option required";
    }
    my $repo = $self->repo;
    my $git = $self->{git_path};
    my $system;
    if (-d $self->{deploy_to}) {
        # ディレクトリがある。多分git fetchできる
        my @branch = map {chomp; [split(/\s/, $_)]->[-1]} `cd $self->{deploy_to} && $git branch`;
        my $option = grep( {$_ eq $self->{branch}} @branch ) ? 'q' : 'qb';
        $system = <<END;
cd $self->{deploy_to} && \
    $git fetch && \
    $git checkout -$option $self->{branch}
END
        warn $system;
    } else {
        my $dirname = dirname($self->{deploy_to});
        -d $dirname or die "$self->{deploy_to} nor its parent directory not found";
        my $basename = basename($self->{deploy_to});
        $system = <<END
cd $dirname && \
    $git clone $repo $basename && \
    cd $basename && \
    $git checkout -qb $self->{branch} origin/$self->{branch}
END
    }
    if ($system) {
        my $ret = system($system);
        $ret == 0 or die "deploy failed";
    } else {
        return;
    }
}

1;
