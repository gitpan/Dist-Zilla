package Dist::Zilla::Plugin::MetaTests;
our $VERSION = '1.091370';

# ABSTRACT: common extra tests for META.yml
use Moose;
extends 'Dist::Zilla::Plugin::InlineFiles';


override 'gather_files' => sub {
  my ($self) = @_;
  return unless $ENV{RELEASE_TESTING};
  super();
};

__PACKAGE__->meta->make_immutable;
no Moose;
1;




=pod

=head1 NAME

Dist::Zilla::Plugin::MetaTests - common extra tests for META.yml

=head1 VERSION

version 1.091370

=head1 DESCRIPTION

This is an extension of L<Dist::Zilla::Plugin::InlineFiles>, providing the
following files:

      xt/release/meta-yaml.t - a standard Test::CPAN::Meta test

This file is only gathered if the environment variable C<RELEASE_TESTING> is
true, which is the case when running C<dzil test>.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 



__DATA__
___[ xt/release/meta-yaml.t ]___
#!perl -T

use Test::More;

eval "use Test::CPAN::Meta";
plan skip_all => "Test::CPAN::Meta required for testing META.yml" if $@;
meta_yaml_ok();
