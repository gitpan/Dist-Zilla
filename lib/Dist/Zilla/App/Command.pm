use strict;
use warnings;
package Dist::Zilla::App::Command;
our $VERSION = '1.091480';

# ABSTRACT: base class for dzil commands
use App::Cmd::Setup -command;
use Moose::Autobox;


sub zilla {
  my ($self) = @_;

  require Dist::Zilla;
  return $self->{__PACKAGE__}{zilla} ||= do {
    my $zilla = Dist::Zilla->from_config;
    $zilla->dzil_app($self->app);
    $zilla;
  }
}


sub config {
  my ($self) = @_;
  return $self->{__PACKAGE__}{config} ||= $self->app->config_for(ref $self);
}


sub log {
  require Dist::Zilla::Util;
  shift; Dist::Zilla::Util->_log($_[0]);
}

1;

__END__

=pod

=head1 NAME

Dist::Zilla::App::Command - base class for dzil commands

=head1 VERSION

version 1.091480

=head1 METHODS

=head2 zilla

This returns the Dist::Zilla object in use by the command.  If none has yet
been constructed, one will be by calling C<< Dist::Zilla->from_config >>.

=head2 config

This method returns the configuration for the current command.

=head2 log

This method calls the C<log> method of the command's L<Dist::Zilla|Dist::Zilla>
object.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


