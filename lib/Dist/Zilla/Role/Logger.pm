package Dist::Zilla::Role::Logger;
our $VERSION = '1.100630';
use Moose::Role;
use namespace::autoclean;

requires 'log';
requires 'log_debug';

sub log_for_plugin       { die '...' }
sub log_debug_for_plugin { die '...' }


1;

__END__
=pod

=head1 NAME

Dist::Zilla::Role::Logger

=head1 VERSION

version 1.100630

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

