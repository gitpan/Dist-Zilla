package Dist::Zilla::Plugin::FakeRelease;
our $VERSION = '1.093370';
# ABSTRACT: fake plugin to test release

use Moose;

with 'Dist::Zilla::Role::Releaser';

sub release {
  my $self = shift;
  die '[FakeRelease] DIST_ZILLA_FAKERELEASE_FAIL set, aborting'
    if $ENV{DIST_ZILLA_FAKERELEASE_FAIL};
  $self->log( '[FakeRelease] Fake realase happening (nothing was really done)' );
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;


=pod

=head1 NAME

Dist::Zilla::Plugin::FakeRelease - fake plugin to test release

=head1 VERSION

version 1.093370

=head1 DESCRIPTION

This plugin is a C<Releaser> that does nothing. It is directed to plugin
authors, who may need a dumb release plugin to test their shiny plugin
implementing C<BeforeRelease> and C<AfterRelease>.

When this plugin does the release, it will just log a message and finish.

If you happen to have a C<DIST_ZILLA_FAKERELEASE_FAIL> environment var
set, the plugin will die instead of logging and exiting nicely. This can
be interesting for authors wanting to test reliably that release failed.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

