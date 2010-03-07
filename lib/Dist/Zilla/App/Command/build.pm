use strict;
use warnings;
package Dist::Zilla::App::Command::build;
our $VERSION = '1.100660';
# ABSTRACT: build your dist
use Dist::Zilla::App -command;


sub abstract { 'build your dist' }


sub opt_spec {
  [ 'tgz!', 'build a tarball (default behavior)', { default => 1 } ]
}


sub execute {
  my ($self, $opt, $arg) = @_;

  my $method = $opt->{tgz} ? 'build_archive' : 'build_in';
  $self->zilla->$method;
}

1;

__END__
=pod

=head1 NAME

Dist::Zilla::App::Command::build - build your dist

=head1 VERSION

version 1.100660

=head1 SYNOPSIS

Builds your distribution and emits tar.gz files / directories.

    dzil build [--tgz|--notgz]

=head1 EXAMPLE

    $ dzil build
    $ dzil build --tgz
    $ dzil build --notgz

=head1 OPTIONS

=head2 --tgz | --notgz

Builds a .tar.gz in your project directory after building the distribution.

--tgz behaviour is by default, use --notgz to disable building an archive.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

