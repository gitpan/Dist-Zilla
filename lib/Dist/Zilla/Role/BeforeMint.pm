package Dist::Zilla::Role::BeforeMint;
# ABSTRACT: something that runs before minting really begins
$Dist::Zilla::Role::BeforeMint::VERSION = '5.010';
use Moose::Role;
with 'Dist::Zilla::Role::Plugin';

use namespace::autoclean;

# =head1 DESCRIPTION
# 
# Plugins implementing this role have their C<before_mint> method called
# before any other plugins are consulted.
# 
# =cut

requires 'before_mint';

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Role::BeforeMint - something that runs before minting really begins

=head1 VERSION

version 5.010

=head1 DESCRIPTION

Plugins implementing this role have their C<before_mint> method called
before any other plugins are consulted.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
