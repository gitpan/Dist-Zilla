package Dist::Zilla::Logger::Global;
our $VERSION = '1.100630_001';
use MooseX::Singleton;

use Log::Dispatchouli 0.004;

use namespace::autoclean;

has ident  => (
  is => 'ro',
  default => 'Dist::Zilla',
);

has logger => (
  is   => 'ro',
  isa  => 'Log::Dispatchouli',
  lazy => 1,
  handles => [ qw(log log_debug) ],
  default => sub {
    return Log::Dispatchouli->new({
      ident     => $_[0]->ident,
      to_stdout => 1,
      log_pid   => 0,
    });
  },
);

with 'Dist::Zilla::Role::Logger';
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Logger::Global

=head1 VERSION

version 1.100630_001

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

