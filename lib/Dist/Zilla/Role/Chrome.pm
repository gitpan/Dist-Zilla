package Dist::Zilla::Role::Chrome;
# ABSTRACT: something that provides a user interface for Dist::Zilla
$Dist::Zilla::Role::Chrome::VERSION = '5.030';
use Moose::Role;

use namespace::autoclean;

requires 'logger';

requires 'prompt_str';
requires 'prompt_yn';
requires 'prompt_any_key';

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Role::Chrome - something that provides a user interface for Dist::Zilla

=head1 VERSION

version 5.030

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
