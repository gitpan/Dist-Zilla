package Dist::Zilla::Prereqs;
$Dist::Zilla::Prereqs::VERSION = '2.100870';
# ABSTRACT: the prerequisites of a Dist::Zilla distribution
use Moose;
use Moose::Autobox;
use MooseX::Types::Moose qw(Bool HashRef);

use Hash::Merge::Simple ();
use Path::Class ();
use String::RewritePrefix;
use Version::Requirements;

use namespace::autoclean;

has is_finalized => (
  is  => 'ro',
  isa => Bool,
  traits  => [ qw(Bool) ],
  default => 0,
  handles => {
    finalize => 'set',
  },
);

has _guts => (
  is  => 'ro',
  isa => HashRef,
  default  => sub { {} },
  init_arg => undef,
);

sub as_distmeta {
  my ($self) = @_;

  my $distmeta = {
    requires           =>
      ($self->_guts->{runtime}{requires} || Version::Requirements->new)
      ->as_string_hash,
    build_requires     =>
      ($self->_guts->{build}{requires} || Version::Requirements->new)
      ->as_string_hash,
    configure_requires =>
      ($self->_guts->{configure}{requires} || Version::Requirements->new)
      ->as_string_hash,
  };

  return $distmeta;
}

sub register_prereqs {
  my $self = shift;
  my $arg  = ref($_[0]) ? shift(@_) : {};
  my %prereq = @_;

  confess "too late to register a prereq" if $self->is_finalized;

  my $phase = $arg->{phase} || 'runtime';
  my $type  = $arg->{type}  || 'requires';

  $phase = 'build' if $phase eq 'test';

  my $prereq = ($self->_guts->{$phase}{$type} ||= Version::Requirements->new);

  while (my ($package, $version) = each %prereq) {
    $prereq->add_minimum($package, $version);
  }

  return;
}

1;

__END__
=pod

=head1 NAME

Dist::Zilla::Prereqs - the prerequisites of a Dist::Zilla distribution

=head1 VERSION

version 2.100870

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

