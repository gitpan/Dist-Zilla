package Dist::Zilla::MVP::Assembler::Zilla;
BEGIN {
  $Dist::Zilla::MVP::Assembler::Zilla::VERSION = '4.101540';
}
use Moose;
extends 'Dist::Zilla::MVP::Assembler';
# ABSTRACT: Dist::Zilla::MVP::Assembler for the Dist::Zilla object

use MooseX::Types::Perl qw(PackageName);
use Dist::Zilla::MVP::RootSection;

sub BUILD {
  my ($self) = @_;

  my $root = Dist::Zilla::MVP::RootSection->new;
  $self->sequence->add_section($root);
}

has zilla_class => (
  is      => 'ro',
  isa     => PackageName,
  default => 'Dist::Zilla',
);

sub zilla {
  my ($self) = @_;
  $self->sequence->section_named('_')->zilla;
}

sub register_stash {
  my ($self, $name, $object) = @_;
  $self->log_fatal("tried to register $name stash entry twice")
    if $self->zilla->_local_stash->{ $name };

  $self->zilla->_local_stash->{ $name } = $object;
  return;
}

no Moose;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::MVP::Assembler::Zilla - Dist::Zilla::MVP::Assembler for the Dist::Zilla object

=head1 VERSION

version 4.101540

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

