package Dist::Zilla::Role::TestRunner;
$Dist::Zilla::Role::TestRunner::VERSION = '1.100860';

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

version 1.100860

=head1 DESCRIPTION

Plugins implementing this role have their C<test> method called when
testing.  It's passed the root directory of the build test dir.

=head1 REQUIRED METHODS

=head2 test

  ->test( $build_dir )

This method should return C<undef> on success.

Any other value is interpreted as an error message, and no more tests are run.

Calling "die" inside test also will be caught.

The following 2 subs should behave(mostly) the same:

    sub test {
        die "Failed";
    }

    sub test {
        return "Failed";
    }

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

