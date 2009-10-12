package Dist::Zilla::Config::Finder;
our $VERSION = '1.092850';


use Moose;
with qw(Dist::Zilla::Config);
# ABSTRACT: the reader for dist.ini files

use Module::Pluggable::Object;

has module_pluggable_object => (
  is => 'ro',
  init_arg => undef,
  default  => sub {
    Module::Pluggable::Object->new(
      search_path => [ qw(Dist::Zilla::Config) ],
      inner       => 0,
      require     => 1,
    );
  },
);

sub _which_plugin {
  my ($self, $arg) = @_;

  my @plugins = grep { $_->can_be_found($arg) }
                grep { $_->does('Dist::Zilla::ConfigRole::Findable') }
                $self->module_pluggable_object->plugins;

  confess "no viable configuration could be found" unless @plugins;
  confess "multiple possible config plugins found: @plugins" if @plugins > 1;

  return $plugins[0];
}

sub read_config {
  my ($self, $arg) = @_;

  my $plugin = $self->_which_plugin($arg);

  return $plugin->new->read_config($arg);
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Config::Finder - the reader for dist.ini files

=head1 VERSION

version 1.092850

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


