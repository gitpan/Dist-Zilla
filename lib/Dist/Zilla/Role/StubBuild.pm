package Dist::Zilla::Role::StubBuild;
{
  $Dist::Zilla::Role::StubBuild::VERSION = '5.006';
}
# ABSTRACT: provides an empty BUILD methods

use Moose::Role;

sub BUILD {}

1;

__END__

=pod

=head1 NAME

Dist::Zilla::Role::StubBuild - provides an empty BUILD methods

=head1 VERSION

version 5.006

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
