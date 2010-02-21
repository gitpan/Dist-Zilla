use strict;
use warnings;

package Dist::Zilla::App::Command::run;
our $VERSION = '1.100520';
# ABSTRACT: run stuff in a dir where your dist is built

use Dist::Zilla::App -command;
use Moose::Autobox;

sub abstract { 'run stuff in a dir where your dist is built' }

sub execute {
  my ($self, $opts, $args) = @_;

  # The sort below is a cheap hack to get ModuleBuild ahead of
  # ExtUtils::MakeMaker. -- rjbs, 2010-01-05
  Carp::croak("you can't release without any InstallTool plugins")
    unless my @builders =
    $self->zilla->plugins_with(-BuildRunner)->sort->reverse->flatten;

  require Config;
  require File::chdir;
  require File::Temp;
  require Path::Class;

  # dzil-build the dist
  my $build_root = Path::Class::dir('.build');
  $build_root->mkpath unless -d $build_root;

  my $target    = Path::Class::dir( File::Temp::tempdir(DIR => $build_root) );
  my $abstarget = $target->absolute;
  $self->log("building test distribution under $target");

  $self->zilla->ensure_built_in($target);

  # building the dist for real
  my $ok = eval {
    local $File::chdir::CWD = $target;
    $builders[0]->build;
    local $ENV{PERL5LIB} =
      join $Config::Config{path_sep},
      map { $abstarget->subdir('blib', $_) } qw{ arch lib };
    system(@$args) and die "error while running: @$args";
    1;
  };

  if ($ok) {
    $self->log("all's well; removing $target");
    $target->rmtree;
  } else {
    my $error = $@ || '(unknown error)';
    $self->log($error);
    $self->log("left failed dist in place at $target");
    exit 1;
  }
}

1;


=pod

=head1 NAME

Dist::Zilla::App::Command::run - run stuff in a dir where your dist is built

=head1 VERSION

version 1.100520

=head1 SYNOPSIS

    $ dzil run ./bin/myscript
    $ dzil run prove -bv t/mytest.t
    $ dzil run bash

=head1 DESCRIPTION

This command will dzil-build your dist, then build the distribution
and finally run a command in this directory. It's ultimately like
doing this:

    dzil build
    rsync -avp My-Project-version/ .build/
    cd .build
    perl Makefile.PL            # or perl Build.PL
    make                        # or ./Build        
    export PERL5LIB=$PWD/blib/lib:$PWD/blib/arch
    <your command as defined by rest of params>

Except for the fact it's built directly in a subdir of .build (like
F<.build/asdf123>).

A command returning with an non-zero error code will left the build
directory behind for analysis, and dzil will exit with status 1.
Otherwise, the build directory will be removed and dzil will exit
with status 0.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

