use strict;
use warnings;
package Dist::Zilla::App;
our $VERSION = '1.093400';
# ABSTRACT: Dist::Zilla's App::Cmd
use App::Cmd::Setup -app;

use Carp ();
use Dist::Zilla::Config::Finder;
use File::HomeDir ();
use Moose::Autobox;
use Path::Class;

sub config {
  my ($self) = @_;

  my $homedir = File::HomeDir->my_home
    or Carp::croak("couldn't determine home directory");

  my $file = dir($homedir)->file('.dzil');
  return unless -e $file;

  if (-d $file) {
    return Dist::Zilla::Config::Finder->new->read_config({
      root     =>  dir($homedir)->subdir('.dzil'),
      basename => 'config',
    });
  } else {
    return Dist::Zilla::Config::Finder->new->read_config({
      root     => dir($homedir),
      filename => '.dzil',
    });
  }
}

sub config_for {
  my ($self, $plugin_class) = @_;

  return {} unless $self->config;

  my ($section) = grep { ($_->package||'') eq $plugin_class }
                  $self->config->sections;

  return {} unless $section;

  return $section->payload;
}

1;

__END__
=pod

=head1 NAME

Dist::Zilla::App - Dist::Zilla's App::Cmd

=head1 VERSION

version 1.093400

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

