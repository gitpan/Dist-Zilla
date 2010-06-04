package Dist::Zilla::Stash::PAUSE;
BEGIN {
  $Dist::Zilla::Stash::PAUSE::VERSION = '4.101540';
}
use Moose;
with 'Dist::Zilla::Role::Stash';
# ABSTRACT: a stash of your PAUSE credentials

has user => (
  is  => 'ro',
  isa => 'Str',
  required => 1,
);

has password => (
  is  => 'ro',
  isa => 'Str',
  required => 1,
);

1;

__END__
=pod

=head1 NAME

Dist::Zilla::Stash::PAUSE - a stash of your PAUSE credentials

=head1 VERSION

version 4.101540

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

