package Dist::Zilla::Role::MVPReader;
BEGIN {
  $Dist::Zilla::Role::MVPReader::VERSION = '4.101580';
}
use Moose::Role;
# ABSTRACT: stored configuration loader role

use Config::MVP 2; # finalization and what not

use Dist::Zilla::MVP::Assembler::GlobalConfig;
use Dist::Zilla::MVP::Assembler::Zilla;

use MooseX::Types::Perl qw(PackageName);


has assembler_class => (
  is  => 'ro',
  isa => PackageName,
);

sub build_assembler {
  my ($self) = @_;

  confess "neither assembler nor assembler_class were provided"
    unless my $assembler_class = $self->assembler_class;

  return $assembler_class->new
}

no Moose::Role;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Role::MVPReader - stored configuration loader role

=head1 VERSION

version 4.101580

=head1 DESCRIPTION

The config role provides some helpers for writing a configuration loader using
the L<Config::MVP|Config::MVP> system to load and validate its configuration.

=head1 ATTRIBUTES

=head2 assembler

The L<assembler> attribute must be a Config::MVP::Assembler, has a sensible
default that will handle the standard needs of a config loader.  Namely, it
will be pre-loaded with a starting section for root configuration.  That
starting section will alias C<author> to C<authors> and will set that up as a
multivalue argument.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

