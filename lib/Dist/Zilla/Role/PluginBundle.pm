package Dist::Zilla::Role::PluginBundle;
our $VERSION = '1.001';

# ABSTRACT: a bundle of plugins
use Moose::Role;


requires 'bundle_config';

no Moose::Role;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Role::PluginBundle - a bundle of plugins

=head1 VERSION

version 1.001

=head1 DESCRIPTION

When loading configuration, if the config reader encounters a PluginBundle, it
will replace its place in the plugin list with the result of calling its
C<bundle_config> method.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


