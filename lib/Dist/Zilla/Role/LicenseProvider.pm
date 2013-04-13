package Dist::Zilla::Role::LicenseProvider;
{
  $Dist::Zilla::Role::LicenseProvider::VERSION = '4.300034';
}
# ABSTRACT: something that provides a license for the dist
use Moose::Role;
with 'Dist::Zilla::Role::Plugin';


requires 'provide_license';

no Moose::Role;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Role::LicenseProvider - something that provides a license for the dist

=head1 VERSION

version 4.300034

=head1 DESCRIPTION

Plugins implementing this role must provide a C<provide_license> method that
will be called when setting the dist's license.

If a LicenseProvider offers a license but one has already been set, an
exception will be raised.  If C<provides_license> returns undef, it will be
ignored.

=head1 REQUIRED METHODS

=head2 C<< provide_license($copyright_holder, $copyright_year) >>

Generate license object. Returned object should be an instance of
L<Software::License>.

Plugins are responsible for injecting C<$copyright_holder> and
C<$copyright_year> arguments into the license if these arguments are defined.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
