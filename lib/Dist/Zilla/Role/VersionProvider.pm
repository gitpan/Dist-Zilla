package Dist::Zilla::Role::VersionProvider;
our $VERSION = '1.092930';


# ABSTRACT: something that provides a version number for the dist
use Moose::Role;


with 'Dist::Zilla::Role::Plugin';
requires 'provide_version';

no Moose::Role;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Role::VersionProvider - something that provides a version number for the dist

=head1 VERSION

version 1.092930

=head1 DESCRIPTION

Plugins implementing this role must provide a C<provide_version> method that
will be called when setting the dist's version.

If a VersionProvider offers a version but one has already been set, an
exception will be raised.  If C<provides_version> returns undef, it will be
ignored. 

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

