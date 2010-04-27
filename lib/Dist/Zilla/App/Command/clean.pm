use strict;
use warnings;
package Dist::Zilla::App::Command::clean;
BEGIN {
  $Dist::Zilla::App::Command::clean::VERSION = '2.101170';
}
# ABSTRACT: clean up after build, test, or install
use Dist::Zilla::App -command;

use File::Find::Rule;


sub abstract { 'clean up after build, test, or install' }

sub execute {
  my ($self, $opt, $arg) = @_;

  $self->zilla->clean;
}

1;

__END__
=pod

=head1 NAME

Dist::Zilla::App::Command::clean - clean up after build, test, or install

=head1 VERSION

version 2.101170

=head1 SYNOPSIS

Removes some files that are created during build, test, and install.

    dzil clean

=head1 REMOVED FILES

    ^.build
    ^<distribution-name>-*

ie:

    removing .build
    removing Foo-Bar-1.09010
    removing Foo-Bar-1.09010.tar.gz

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

