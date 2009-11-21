package Dist::Zilla::Role::InstallTool;
our $VERSION = '1.093250';


# ABSTRACT: something that creates an install program for a dist
use Moose::Role;
use Moose::Autobox;


with 'Dist::Zilla::Role::Plugin';
with 'Dist::Zilla::Role::FileInjector';
requires 'setup_installer';

no Moose::Role;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Role::InstallTool - something that creates an install program for a dist

=head1 VERSION

version 1.093250

=head1 DESCRIPTION

Plugins implementing InstallTool have their C<setup_installer> method called to
inject files after all other file injection and munging has taken place.
They're expected to write out files needed to make the distribution
installable, like F<Makefile.PL> or F<Build.PL>.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

