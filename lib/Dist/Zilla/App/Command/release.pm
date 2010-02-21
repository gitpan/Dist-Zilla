use strict;
use warnings;
package Dist::Zilla::App::Command::release;
our $VERSION = '1.100520';
# ABSTRACT: release your dist to the CPAN
use Dist::Zilla::App -command;


sub abstract { 'release your dist' }

sub execute {
  my ($self, $opt, $arg) = @_;
  $self->zilla->release;
}

1;

__END__
=pod

=head1 NAME

Dist::Zilla::App::Command::release - release your dist to the CPAN

=head1 VERSION

version 1.100520

=head1 SYNOPSIS

Use ReleasePlugin(s) to release your distribution in many ways.

    dzil release

Put some plugins in your F<dist.ini> that perform
L<Dist::Zilla::Role::Releaser>, such as L<Dist::Zilla::Plugin::UploadToCPAN>

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

