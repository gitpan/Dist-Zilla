package Dist::Zilla::MVP::RootSection;
BEGIN {
  $Dist::Zilla::MVP::RootSection::VERSION = '4.101550';
}
use Moose;
extends 'Config::MVP::Section';
# ABSTRACT: a standard section in Dist::Zilla's configuration sequence

use MooseX::LazyRequire;
use MooseX::SetOnce;
use Moose::Util::TypeConstraints;

has '+name'    => (default => '_');

has '+aliases' => (default => sub { return { author => 'authors' } });

has '+multivalue_args' => (default => sub { [ qw(authors) ] });

has zilla => (
  is     => 'ro',
  isa    => class_type('Dist::Zilla'),
  traits => [ qw(SetOnce) ],
  writer => 'set_zilla',
  lazy_required => 1,
);

after finalize => sub {
  my ($self) = @_;

  my $assembler = $self->sequence->assembler;

  my $zilla = $assembler->zilla_class->new( $self->payload );

  $self->set_zilla($zilla);
};

1;

__END__
=pod

=head1 NAME

Dist::Zilla::MVP::RootSection - a standard section in Dist::Zilla's configuration sequence

=head1 VERSION

version 4.101550

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

