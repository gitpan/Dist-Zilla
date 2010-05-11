use strict;
use warnings;
package Dist::Zilla::App::Command::listdeps;
BEGIN {
  $Dist::Zilla::App::Command::listdeps::VERSION = '2.101310';
}
use Dist::Zilla::App -command;
# ABSTRACT: print your distribution's prerequisites

use Moose::Autobox;
use Version::Requirements;

sub abstract { "print your distribution's prerequisites" }

sub execute {
  my ($self, $opt, $arg) = @_;

  # ...more proof that we need a ->mute setting for Log::Dispatchouli.
  # -- rjbs, 2010-04-29
  $self->app->chrome->_set_logger(
    Log::Dispatchouli->new({ ident => 'Dist::Zilla' }),
  );

  $_->before_build for $self->zilla->plugins_with(-BeforeBuild)->flatten;
  $_->gather_files for $self->zilla->plugins_with(-FileGatherer)->flatten;
  $_->prune_files  for $self->zilla->plugins_with(-FilePruner)->flatten;
  $_->munge_files  for $self->zilla->plugins_with(-FileMunger)->flatten;
  $_->register_prereqs for $self->zilla->plugins_with(-PrereqSource)->flatten;

  my $req = Version::Requirements->new;
  my $prereq = $self->zilla->prereq->as_distmeta;

  for my $type (qw(requires build_requires configure_requires)) {
    $req->add_minimum($_ => $prereq->{ $type }{$_})
      for keys %{ $prereq->{$type} };
  }

  print "$_\n" for sort { lc $a cmp lc $b }
                   grep { $_ ne 'perl' }
                   $req->required_modules;
}

1;


__END__
=pod

=head1 NAME

Dist::Zilla::App::Command::listdeps - print your distribution's prerequisites

=head1 VERSION

version 2.101310

=head1 SYNOPSIS

  $ dzil listdeps | cpan

=head1 DESCRIPTION

This is a command plugin for L<Dist::Zilla>. It provides the C<listdeps>
command, which prints your distribution's prerequisites. You could pipe that
list to a CPAN client like L<cpan> to install all of the dependecies in one
quick go.

=head1 ACKNOWLEDGEMENTS

This code is more or less a direct copy of Marcel Gruenauer (hanekomu)
Dist::Zilla::App::Command::prereqs, updated to work with the Dist::Zilla v2
API.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

