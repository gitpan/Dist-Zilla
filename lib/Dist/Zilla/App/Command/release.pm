use strict;
use warnings;
package Dist::Zilla::App::Command::release;
our $VERSION = '1.093220';


# ABSTRACT: release your dist to the CPAN
use Dist::Zilla::App -command;

use Moose::Autobox;


sub abstract { 'release your dist' }

sub execute {
  my ($self, $opt, $arg) = @_;

  Carp::croak("you can't release without any Releaser plugins")
    unless my @releasers = $self->zilla->plugins_with(-Releaser)->flatten;

  my $tgz = $self->zilla->build_archive;

  # call all plugins implementing BeforeRelease role
  $_->before_release() for $self->zilla->plugins_with(-BeforeRelease)->flatten;

  # do the actual release
  $_->release($tgz) for @releasers;

  # call all plugins implementing AfterRelease role
  $_->after_release() for $self->zilla->plugins_with(-AfterRelease)->flatten;
}

1;

__END__
=pod

=head1 NAME

Dist::Zilla::App::Command::release - release your dist to the CPAN

=head1 VERSION

version 1.093220

=head1 SYNOPSIS

Use ReleasePlugin(s) to release your distribution in many ways.

    dzil release

Put some plugins in your F<dist.ini> that perform
L<Dist::Zilla::Role::Releaser>, such as L<Dist::Zilla::Plugin::UploadToCPAN>

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

