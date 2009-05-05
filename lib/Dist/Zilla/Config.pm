package Dist::Zilla::Config;
our $VERSION = '1.091250';

use Moose::Role;
# ABSTRACT: stored configuration loader role

requires 'default_filename';
requires 'read_file';

sub struct_to_config {
  my ($self, $struct) = @_;

  my $i = 0;
  my $root_config = $struct->[0]{'=name'} eq '_'
                  ? $struct->[ $i++ ]
                  : {};

  $root_config->{authors} = delete $root_config->{author};

  my @plugins;
  for my $plugin (map { $struct->[ $_ ] } ($i .. $#$struct)) {
    my $class = delete $plugin->{'=package'};
    
    if (eval { $class->does('Dist::Zilla::Role::PluginBundle') }) {
      push @plugins, $class->bundle_config($plugin);
    } else {
      push @plugins, [ $class => $plugin ];
    }
  }

  $root_config->{plugins} = \@plugins;

  return $root_config;
}

no Moose::Role;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Config - stored configuration loader role

=head1 VERSION

version 1.091250

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


