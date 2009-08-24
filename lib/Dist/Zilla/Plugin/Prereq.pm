package Dist::Zilla::Plugin::Prereq;
our $VERSION = '1.092360';

# ABSTRACT: list simple prerequisites
use Moose;
with 'Dist::Zilla::Role::FixedPrereqs';


has _prereq => (
  is   => 'ro',
  isa  => 'HashRef',
  default => sub { {} },
);

sub BUILDARGS {
  my ($class, @arg) = @_;
  my %copy = ref $arg[0] ? %{$arg[0]} : @arg;

  my $zilla = delete $copy{zilla};
  my $name  = delete $copy{plugin_name};

  return {
    zilla => $zilla,
    plugin_name => $name,
    _prereq     => \%copy,
  }
}

sub prereq { shift->_prereq }

no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Plugin::Prereq - list simple prerequisites

=head1 VERSION

version 1.092360

=head1 SYNOPSIS

In your F<dist.ini>:

  [Prereq]
  Foo::Bar = 1.002
  MRO::Compat = 10
  Sub::Exporter = 0

=head1 DESCRIPTION

This module adds "fixed" prerequisites to your distribution.  These are prereqs
with a known, fixed minimum version that doens't change based on platform or
other conditions.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


