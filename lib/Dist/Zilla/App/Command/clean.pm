use strict;
use warnings;
package Dist::Zilla::App::Command::clean;
our $VERSION = '1.091480';

# ABSTRACT: clean up after build, test, or install
use Dist::Zilla::App -command;

sub abstract { 'clean up after build, test, or install' }

sub run {
  my ($self, $opt, $arg) = @_;

  require File::Path;
  for my $x (grep { -e } '.build', glob($self->zilla->name . '-*')) {
    $self->log("clean: removing $x");
    File::Path::rmtree($x);
  };
}

1;

__END__

=pod

=head1 NAME

Dist::Zilla::App::Command::clean - clean up after build, test, or install

=head1 VERSION

version 1.091480

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


