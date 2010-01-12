package Dist::Zilla::Role::FileGatherer;
our $VERSION = '1.100120';
use Moose::Autobox;
# ABSTRACT: something that gathers files into the distribution
use Moose::Role;


with 'Dist::Zilla::Role::Plugin';
with 'Dist::Zilla::Role::FileInjector';
requires 'gather_files';

no Moose::Role;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Role::FileGatherer - something that gathers files into the distribution

=head1 VERSION

version 1.100120

=head1 DESCRIPTION

A FileGatherer plugin is a special sort of
L<FileInjector|Dist::Zilla::Role::FileInjector> that runs early in the build
cycle, finding files to include in the distribution.  It is expected to call
its C<add_file> method to add one or more files to inclusion.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

