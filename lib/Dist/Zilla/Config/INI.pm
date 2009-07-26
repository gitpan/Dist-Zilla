package Dist::Zilla::Config::INI;
our $VERSION = '1.092070';

use Moose;
with qw(
  Dist::Zilla::Config
  Dist::Zilla::ConfigRole::Findable
  Dist::Zilla::ConfigRole::MVP
);
# ABSTRACT: the reader for dist.ini files

use Config::INI::MVP::Reader;


# Clearly this should be an attribute with a builder blah blah blah. -- rjbs,
# 2009-07-25
sub default_filename { 'dist.ini' }
sub filename         { $_[0]->default_filename }

sub can_be_found {
  my ($self, $arg) = @_;

  my $config_file = $arg->{root}->file( $self->filename );
  return -r "$config_file" and -f _;
}

sub read_config {
  my ($self, $arg) = @_;
  my $config_file = $arg->{root}->file( $self->filename );

  my $ini = Config::INI::MVP::Reader->new({ assembler => $self->assembler });
  $ini->read_file($config_file);

  return $self->config_struct;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Config::INI - the reader for dist.ini files

=head1 VERSION

version 1.092070

=head1 DESCRIPTION

Dist::Zilla::Config reads in the F<dist.ini> file for a distribution.  It uses
L<Config::INI::MVP::Reader> to do most of the heavy lifting, using the helpers
set up in L<Dist::Zilla::Role::ConfigMVP>.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


