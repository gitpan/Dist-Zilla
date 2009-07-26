package Dist::Zilla::Role::Plugin;
our $VERSION = '1.092071';

# ABSTRACT: something that gets plugged in to Dist::Zilla
use Moose::Role;


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
  handles  => [ qw(log) ],
);


no Moose::Role;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Role::Plugin - something that gets plugged in to Dist::Zilla

=head1 VERSION

version 1.092071

=head1 DESCRIPTION

The Plugin role should be applied to all plugin classes.  It provides a few key
methods and attributes that all plugins will need.

=head1 ATTRIBUTES

=head2 plugin_name

The plugin name is generally determined when configuration is read.  It is
initialized by the C<=name> argument to the plugin's constructor.

=head2 zilla

This attribute contains the Dist::Zilla object into which the plugin was
plugged.

=head1 METHODS

=head2 log

The plugin's C<log> method delegates to the Dist::Zilla object's
L<Dist::Zilla/log> method.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


