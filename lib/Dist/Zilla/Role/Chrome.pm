package Dist::Zilla::Role::Chrome;
BEGIN {
  $Dist::Zilla::Role::Chrome::VERSION = '4.101540';
}
use Moose::Role;
# ABSTRACT: something that provides a user interface for Dist::Zilla

requires 'logger';

1;

__END__
=pod

=head1 NAME

Dist::Zilla::Role::Chrome - something that provides a user interface for Dist::Zilla

=head1 VERSION

version 4.101540

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

