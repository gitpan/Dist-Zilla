package Dist::Zilla::Role::FixedPrereqs;
our $VERSION = '1.092200';

# ABSTRACT: enumerate fixed (non-conditional) prerequisites
use Moose::Role;


with 'Dist::Zilla::Role::Plugin';
requires 'prereq';

no Moose::Role;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Role::FixedPrereqs - enumerate fixed (non-conditional) prerequisites

=head1 VERSION

version 1.092200

=head1 DESCRIPTION

FixedPrereqs plugins have a C<prereq> method that should return a hashref of
prerequisite package names and versions, indicating unconditional prerequisites
to be merged together.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


