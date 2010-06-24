package Dist::Zilla::Role::BeforeMint;
BEGIN {
  $Dist::Zilla::Role::BeforeMint::VERSION = '4.101740';
}
# ABSTRACT: something that runs before minting really begins
use Moose::Role;
with 'Dist::Zilla::Role::Plugin';


requires 'before_mint';

no Moose::Role;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Role::BeforeMint - something that runs before minting really begins

=head1 VERSION

version 4.101740

=head1 DESCRIPTION

Plugins implementing this role have their C<before_mint> method called
before any other plugins are consulted.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

