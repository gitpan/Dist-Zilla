use strict;
use warnings;
package Dist::Zilla::App::Command::build;
our $VERSION = '1.007';

# ABSTRACT: build your dist
use Dist::Zilla::App -command;

sub abstract { 'build your dist' }

sub opt_spec {
  [ 'tgz!', 'build a tarball (default behavior)', { default => 1 } ]
}

sub run {
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

version 1.007

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


