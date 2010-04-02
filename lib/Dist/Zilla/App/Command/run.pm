use strict;
use warnings;

package Dist::Zilla::App::Command::run;
BEGIN {
  $Dist::Zilla::App::Command::run::VERSION = '2.100922';
}
# ABSTRACT: run stuff in a dir where your dist is built

use Dist::Zilla::App -command;
use Moose::Autobox;

sub abstract { 'run stuff in a dir where your dist is built' }

sub execute {
  my ($self, $opts, $args) = @_;

  $self->zilla->run_in_build($args);
}

1;


=pod

=head1 NAME

Dist::Zilla::App::Command::run - run stuff in a dir where your dist is built

=head1 VERSION

version 2.100922

=head1 SYNOPSIS

  $ dzil run ./bin/myscript
  $ dzil run prove -bv t/mytest.t
  $ dzil run bash

=head1 DESCRIPTION

This command will build your dist with Dist::Zilla, then build the
distribution and then run a command in the build directory. It's like
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
directory behind for analysis, and dzil will exit with a non-zero status.
Otherwise, the build directory will be removed and dzil will exit
with status zero.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

