package Dist::Zilla::MVP::Assembler::GlobalConfig;
BEGIN {
  $Dist::Zilla::MVP::Assembler::GlobalConfig::VERSION = '4.101550';
}
use Moose;
extends 'Dist::Zilla::MVP::Assembler';
# ABSTRACT: Dist::Zilla::MVP::Assembler for global configuration

has stash => (
  is  => 'ro',
  isa => 'HashRef[Object]',
  default => sub { {} },
);

sub register_stash {
  my ($self, $name, $object) = @_;

  # $self->log_fatal("tried to register $name stash entry twice")
  confess("tried to register $name stash entry twice")
    if $self->stash->{ $name };

  $self->stash->{ $name } = $object;
  return;
}

no Moose;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::MVP::Assembler::GlobalConfig - Dist::Zilla::MVP::Assembler for global configuration

=head1 VERSION

version 4.101550

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

