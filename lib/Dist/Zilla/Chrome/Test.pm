package Dist::Zilla::Chrome::Test;
BEGIN {
  $Dist::Zilla::Chrome::Test::VERSION = '4.101900';
}
use Moose;
# ABSTRACT: the chrome used by Dist::Zilla::Tester

use Dist::Zilla::Types qw(OneZero);
use Log::Dispatchouli;

has logger => (
  is => 'ro',
  default => sub {
    Log::Dispatchouli->new({
      ident   => 'Dist::Zilla::Tester',
      log_pid => 0,
      to_self => 1,
    });
  }
);

sub prompt_str {
  my ($self, $prompt, $arg) = @_;
  $arg ||= {};
  my $default = $arg->{default};

  $self->logger->log_fatal("no default response for test prompt_yn")
    unless defined $default;

  return $default;
}

sub prompt_yn {
  my ($self, $prompt, $arg) = @_;
  $arg ||= {};
  my $default = $arg->{default};

  $self->logger->log_fatal("no default response for test prompt_yn")
    unless defined $default;

  return OneZero->coerce($default);
}

sub prompt_any_key { return }

with 'Dist::Zilla::Role::Chrome';
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Chrome::Test - the chrome used by Dist::Zilla::Tester

=head1 VERSION

version 4.101900

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

