use strict;
use warnings;
package Dist::Zilla::App::Command;
our $VERSION = '1.002';

# ABSTRACT: base class for dzil commands
use App::Cmd::Setup -command;


sub zilla {
  my ($self) = @_;

  require Dist::Zilla;
  return $self->{__PACKAGE__}{zilla} ||= Dist::Zilla->from_config;
}


sub log { shift->zilla->log(@_) } ## no critic

1;

__END__

=pod

=head1 NAME

Dist::Zilla::App::Command - base class for dzil commands

=head1 VERSION

version 1.002

=head1 METHODS

=head2 zilla

This returns the Dist::Zilla object in use by the command.  If none has yet
been constructed, one will be by calling C<< Dist::Zilla->from_config >>.

=head2 log

This method calls the C<log> method of the command's L<Dist::Zilla|Dist::Zilla>
object.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


