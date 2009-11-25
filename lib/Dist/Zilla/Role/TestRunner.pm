package Dist::Zilla::Role::TestRunner;
our $VERSION = '1.093290';



# ABSTRACT: something used as a delegating agent to 'dzil test'

use Moose::Role;


with 'Dist::Zilla::Role::Plugin';


requires 'test';

no Moose::Role;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Role::TestRunner - something used as a delegating agent to 'dzil test'

=head1 VERSION

version 1.093290

=head1 DESCRIPTION

Plugins implementing this role have their C<test> method called when
testing.  It's passed the root directory of the build test dir.

=head1 REQUIRED METHODS

=head2 test

  ->test( $build_dir )

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

