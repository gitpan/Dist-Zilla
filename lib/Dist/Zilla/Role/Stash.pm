package Dist::Zilla::Role::Stash;
BEGIN {
  $Dist::Zilla::Role::Stash::VERSION = '4.101800';
}
# ABSTRACT: something that stores options or data for later reference
use Moose::Role;

sub register_component {
  my ($class, $name, $arg, $section) = @_;

  # $self->log_debug([ 'online, %s v%s', $self->meta->name, $version ]);
  my $entry = $class->stash_from_config($name, $arg, $section);

  $section->sequence->assembler->register_stash($name, $entry);

  return;
}

sub stash_from_config {
  my ($class, $name, $arg, $section) = @_;

  my $self = $class->new($arg);
  return $self;
}

1;

__END__
=pod

=head1 NAME

Dist::Zilla::Role::Stash - something that stores options or data for later reference

=head1 VERSION

version 4.101800

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

