package Dist::Zilla::Plugin::MakeMaker::Runner;
BEGIN {
  $Dist::Zilla::Plugin::MakeMaker::Runner::VERSION = '4.102346';
}
# ABSTRACT: Test and build dists with a Makefile.PL

use Moose;
with 'Dist::Zilla::Role::BuildRunner';
with 'Dist::Zilla::Role::TestRunner';

use Config;

has 'make_path' => (
  isa => 'Str',
  is  => 'ro',
  default => $Config{make} || 'make',
);

sub build {
  my $self = shift;

  my $make = $self->make_path;
  system($^X => 'Makefile.PL') and die "error with Makefile.PL\n";
  system($make)                and die "error running $make\n";

  return;
}

sub test {
  my ( $self, $target ) = @_;

  my $make = $self->make_path;
  $self->build;
  system($make, 'test') and die "error running $make test\n";

  return;
}

1;

__END__
=pod

=head1 NAME

Dist::Zilla::Plugin::MakeMaker::Runner - Test and build dists with a Makefile.PL

=head1 VERSION

version 4.102346

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

