use strict;
use warnings;
package Dist::Zilla::App::Command::smoke;
our $VERSION = '1.091940';

# ABSTRACT: smoke your dist
use Dist::Zilla::App -command;
require Dist::Zilla::App::Command::test;

sub abstract { 'smoke your dist' }

sub run {
  my $self = shift;

  local $ENV{AUTOMATED_TESTING} = 1;
  local @ARGV = qw(test);

  return $self->app->run;
}

1;

__END__

=pod

=head1 NAME

Dist::Zilla::App::Command::smoke - smoke your dist

=head1 VERSION

version 1.091940

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


