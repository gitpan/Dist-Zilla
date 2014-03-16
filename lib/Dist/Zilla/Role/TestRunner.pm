package Dist::Zilla::Role::TestRunner;
# ABSTRACT: something used as a delegating agent to 'dzil test'
$Dist::Zilla::Role::TestRunner::VERSION = '5.014';
use Moose::Role;
with 'Dist::Zilla::Role::Plugin';

use namespace::autoclean;

# =head1 DESCRIPTION
#
# Plugins implementing this role have their C<test> method called when
# testing.  It's passed the root directory of the build test dir and an
# optional hash reference of arguments.  Valid arguments include:
#
# =for :list
# * jobs -- if parallel testing is supported, this indicates how many to run at once
#
# =method test
#
# This method should throw an exception on failure.
#
# =cut

requires 'test';

# =attr default_jobs
#
# This attribute is the default value that should be used as the C<jobs> argument
# to the C<test> method.
#
# =cut

has default_jobs => (
  is      => 'ro',
  isa     => 'Int', # non-negative
  default => 1,
);

around dump_config => sub {
  my ($orig, $self) = @_;
  my $config = $self->$orig;

  $config->{'' . __PACKAGE__} = { default_jobs => $self->default_jobs };

  return $config;
};

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Role::TestRunner - something used as a delegating agent to 'dzil test'

=head1 VERSION

version 5.014

=head1 DESCRIPTION

Plugins implementing this role have their C<test> method called when
testing.  It's passed the root directory of the build test dir and an
optional hash reference of arguments.  Valid arguments include:

=over 4

=item *

jobs -- if parallel testing is supported, this indicates how many to run at once

=back

=head1 ATTRIBUTES

=head2 default_jobs

This attribute is the default value that should be used as the C<jobs> argument
to the C<test> method.

=head1 METHODS

=head2 test

This method should throw an exception on failure.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
