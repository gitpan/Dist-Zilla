package Dist::Zilla::Role::Plugin;
BEGIN {
  $Dist::Zilla::Role::Plugin::VERSION = '2.101040';
}
# ABSTRACT: something that gets plugged in to Dist::Zilla
use Moose::Role;

with 'Dist::Zilla::Role::ConfigDumper';

use Params::Util qw(_HASHLIKE);

use namespace::autoclean;


has plugin_name => (
  is  => 'ro',
  isa => 'Str',
  required => 1,
);


has zilla => (
  is  => 'ro',
  isa => 'Dist::Zilla',
  required => 1,
  weak_ref => 1,
);


has logger => (
  is   => 'ro',
  lazy => 1,
  handles => [ qw(log log_debug log_fatal) ],
  default => sub {
    $_[0]->zilla->chrome->logger->proxy({
      proxy_prefix => '[' . $_[0]->plugin_name . '] ',
    });
  },
);

# We define these effectively-pointless subs here to allow other roles to
# modify them with around. -- rjbs, 2010-03-21
sub mvp_multivalue_args {};
sub mvp_aliases         { return {} };

no Moose::Role;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Role::Plugin - something that gets plugged in to Dist::Zilla

=head1 VERSION

version 2.101040

=head1 DESCRIPTION

The Plugin role should be applied to all plugin classes.  It provides a few key
methods and attributes that all plugins will need.

=head1 ATTRIBUTES

=head2 plugin_name

The plugin name is generally determined when configuration is read.

=head2 zilla

This attribute contains the Dist::Zilla object into which the plugin was
plugged.

=head1 METHODS

=head2 log

The plugin's C<log> method delegates to the Dist::Zilla object's
L<Dist::Zilla/log> method after including a bit of argument-munging.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

