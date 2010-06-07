package Dist::Zilla::Chrome::Term;
BEGIN {
  $Dist::Zilla::Chrome::Term::VERSION = '4.101581';
}
use Moose;
# ABSTRACT: chrome used for terminal-based interaction


use Log::Dispatchouli;

has logger => (
  is  => 'ro',
  isa => 'Log::Dispatchouli',
  init_arg => undef,
  writer   => '_set_logger',
  default  => sub {
    Log::Dispatchouli->new({
      ident     => 'Dist::Zilla',
      to_stdout => 1,
      log_pid   => 0,
      to_self   => ($ENV{DZIL_TESTING} ? 1 : 0),
      quiet_fatal => 'stdout',
    });
  }
);

with 'Dist::Zilla::Role::Chrome';
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Chrome::Term - chrome used for terminal-based interaction

=head1 VERSION

version 4.101581

=head1 OVERVIEW

This class provides a L<Dist::Zilla::Chrome> implementation for use in a
terminal environment.  It's the default chrome used by L<Dist::Zilla::App>.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

