use strict;
use warnings;

package Dist::Zilla::Role::BeforeRelease;
our $VERSION = '1.093290';


# ABSTRACT: something that runs before release really begins

use Moose::Role;

with 'Dist::Zilla::Role::Plugin';
requires 'before_release';

no Moose::Role;
1;


=pod

=head1 NAME

Dist::Zilla::Role::BeforeRelease - something that runs before release really begins

=head1 VERSION

version 1.093290

=head1 DESCRIPTION

Plugins implementing this role have their C<before_release> method
called before the release is actually done.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

