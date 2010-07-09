package Dist::Zilla::Plugin::Prereq;
BEGIN {
  $Dist::Zilla::Plugin::Prereq::VERSION = '4.101900';
}
# ABSTRACT: DEPRECATED: the old name of the Prereqs plugin
use Moose;
extends 'Dist::Zilla::Plugin::Prereqs';


no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Plugin::Prereq - DEPRECATED: the old name of the Prereqs plugin

=head1 VERSION

version 4.101900

=head1 SYNOPSIS

This plugin extends C<[Prereqs]> and adds nothing.  It is the old name for
Prereqs, and will be removed in a few versions.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

