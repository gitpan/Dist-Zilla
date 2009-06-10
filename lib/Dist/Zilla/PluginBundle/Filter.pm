package Dist::Zilla::PluginBundle::Filter;
our $VERSION = '1.091610';

# ABSTRACT: use another bundle, with some plugins removed
use Moose;
use Moose::Autobox;
with 'Dist::Zilla::Role::PluginBundle';

use Dist::Zilla::Util;


sub multivalue_args { return qw(remove) }

sub bundle_config {
  my ($self, $config) = @_;
  my $class = (ref $self) || $self;

  Carp::croak("no bundle given for bundle filter")
    unless my $bundle = $config->{bundle};

  $bundle = Dist::Zilla::Util->expand_config_package_name($bundle);

  eval "require $bundle; 1" or die;

  my @plugins = $bundle->bundle_config;

  return @plugins unless my $remove = $config->{remove};

  require List::MoreUtils;
  for my $i (reverse 0 .. $#plugins) {
    splice @plugins, $i, 1 if List::MoreUtils::any(sub {
      $plugins[$i][0] eq Dist::Zilla::Util->expand_config_package_name($_)
    }, @$remove);
  }

  return @plugins;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::PluginBundle::Filter - use another bundle, with some plugins removed

=head1 VERSION

version 1.091610

=head1 SYNOPSIS

In your F<dist.ini>:

  [@Filter]
  bundle = @Classic
  remove = PodVersion
  remove = Manifest

=head1 DESCRIPTION

This plugin bundle actually wraps and modified another plugin bundle.  It
includes all the configuration for the bundle named in the C<bundle> attribute,
but removes all the entries whose package is given in the C<remove> attributes.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


