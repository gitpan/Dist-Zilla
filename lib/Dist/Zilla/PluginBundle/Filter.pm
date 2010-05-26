package Dist::Zilla::PluginBundle::Filter;
BEGIN {
  $Dist::Zilla::PluginBundle::Filter::VERSION = '3.101460';
}
# ABSTRACT: use another bundle, with some plugins removed
use Moose;
use Moose::Autobox;
with 'Dist::Zilla::Role::PluginBundle';

use Dist::Zilla::Util;


sub mvp_multivalue_args { qw(remove) }

sub bundle_config {
  my ($self, $section) = @_;
  my $class = (ref $self) || $self;

  my $config = $section->{payload};

  Carp::croak("no bundle given for bundle filter")
    unless my $bundle = $config->{bundle};

  $bundle = Dist::Zilla::Util->expand_config_package_name($bundle);

  eval "require $bundle; 1" or die;

  my @plugins = $bundle->bundle_config({
    name    => $section->{name}, # not 100% sure about this -- rjbs, 2010-03-06
    package => $bundle,
    payload => {},
  });

  return @plugins unless my $remove = $config->{remove};

  require List::MoreUtils;
  for my $i (reverse 0 .. $#plugins) {
    splice @plugins, $i, 1 if List::MoreUtils::any(sub {
      $plugins[$i][1] eq Dist::Zilla::Util->expand_config_package_name($_)
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

version 3.101460

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

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

