use strict;
use warnings;
package Dist::Zilla::App;
BEGIN {
  $Dist::Zilla::App::VERSION = '2.100960';
}
# ABSTRACT: Dist::Zilla's App::Cmd
use App::Cmd::Setup 0.307 -app; # need ->app in Result of Tester, GLD vers

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

sub global_opt_spec {
  return (
    [ "verbose|v:s@", "log additional output" ],
    [ "inc|I=s@",     "additional \@INC dirs", {
        callbacks => { 'always fine' => sub { unshift @INC, @{$_[0]}; } }
    } ]
  );
}


sub logger {
  my ($self) = @_;
  $self->{__logger__} ||= Log::Dispatchouli->new({
    ident     => 'Dist::Zilla',
    to_stdout => 1,
    log_pid   => 0,
    to_self   => ($ENV{DZIL_TESTING} ? 1 : 0),
    quiet_fatal => 'stdout',
  });
}

sub zilla {
  my ($self) = @_;

  require Dist::Zilla;

  return $self->{__PACKAGE__}{zilla} ||= do {
    my @v_plugins = $self->global_options->verbose
                  ? grep { length } @{ $self->global_options->verbose }
                  : ();

    my $verbose = $self->global_options->verbose && ! @v_plugins;

    $self->logger->set_debug($verbose ? 1 : 0);

    my $core_debug = grep { m/\A[-_]\z/ } @v_plugins;

    my $zilla = Dist::Zilla->from_config({
      chrome => $self,
    });

    $zilla->logger->set_debug($verbose ? 1 : 0);

    VERBOSE_PLUGIN: for my $plugin_name (grep { ! m{\A[-_]\z} } @v_plugins) {
      $zilla->log_fatal("can't find plugin $plugin_name to set debug mode")
        unless my $plugin = $zilla->plugin_named($plugin_name);

      $plugin->logger->set_debug(1);
    }

    $zilla;
  }
}

1;

__END__
=pod

=head1 NAME

Dist::Zilla::App - Dist::Zilla's App::Cmd

=head1 VERSION

version 2.100960

=head1 METHODS

=head2 zilla

This returns the Dist::Zilla object in use by the command.  If none has yet
been constructed, one will be by calling C<< Dist::Zilla->from_config >>.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

