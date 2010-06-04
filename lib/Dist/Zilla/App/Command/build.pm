use strict;
use warnings;
package Dist::Zilla::App::Command::build;
BEGIN {
  $Dist::Zilla::App::Command::build::VERSION = '4.101550';
}
# ABSTRACT: build your dist
use Dist::Zilla::App -command;


sub abstract { 'build your dist' }


sub opt_spec {
  [ 'trial'  => 'build a trial release that PAUSE will not index'      ],
  [ 'tgz!'   => 'build a tarball (default behavior)', { default => 1 } ],
  [ 'in=s'   => 'the directory in which to build the distribution'     ]
}


sub execute {
  my ($self, $opt, $args) = @_;

  if ($opt->in) {
    $self->zilla->build_in($opt->in);
  } else {
    my $method = $opt->tgz ? 'build_archive' : 'build';
    my $zilla  = $self->zilla;
    $zilla->is_trial(1) if $opt->trial;
    $zilla->$method;
  }
}

1;

__END__
=pod

=head1 NAME

Dist::Zilla::App::Command::build - build your dist

=head1 VERSION

version 4.101550

=head1 SYNOPSIS

Builds your distribution and emits tar.gz files / directories.

    dzil build [ --tgz | --no-tgz | --in /path/to/build/dir ]

=head1 EXAMPLE

    $ dzil build
    $ dzil build --tgz
    $ dzil build --no-tgz
    $ dzil build --in /path/to/build/dir

=head1 OPTIONS

=head2 --tgz | --no-tgz

Builds a .tar.gz in your project directory after building the distribution.

--tgz behaviour is by default, use --no-tgz to disable building an archive.

=head2 --in

Specifies the directory into which the distribution should be built.  If
necessary, the directory will be created.  An archive will not be created.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

