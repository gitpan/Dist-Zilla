use strict;
use warnings;

package Dist::Zilla::Role::BuildRunner;
our $VERSION = '1.100651';
# ABSTRACT: something used as a delegating agent during 'dzil run'

use Moose::Role;

with 'Dist::Zilla::Role::Plugin';
requires 'test';

no Moose::Role;
1;


=pod

=head1 NAME

Dist::Zilla::Role::BuildRunner - something used as a delegating agent during 'dzil run'

=head1 VERSION

version 1.100651

=head1 DESCRIPTION

Plugins implementing this role have their C<build> method called during
C<dzil run>. It's passed the root directory of the build test dir.

=head1 REQUIRED METHODS

=head2 build()

This method should return C<undef> on success. Any other value is
interpreted as an error message.

Calling "die" inside build also will be caught.

The following 2 subs should behave(mostly) the same:

    sub build {
        die "Failed";
    }

    sub build {
        return "Failed";
    }

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

