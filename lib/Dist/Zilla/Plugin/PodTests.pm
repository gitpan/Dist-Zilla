package Dist::Zilla::Plugin::PodTests;
our $VERSION = '1.100651';
# ABSTRACT: common extra tests for pod
use Moose;
extends 'Dist::Zilla::Plugin::InlineFiles';


__PACKAGE__->meta->make_immutable;
no Moose;
1;



=pod

=head1 NAME

Dist::Zilla::Plugin::PodTests - common extra tests for pod

=head1 VERSION

version 1.100651

=head1 DESCRIPTION

This is an extension of L<Dist::Zilla::Plugin::InlineFiles>, providing the
following files:

  xt/release/pod-coverage.t - a standard Test::Pod::Coverage test
  xt/release/pod-syntax.t   - a standard Test::Pod test

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__DATA__
___[ xt/release/pod-coverage.t ]___
#!perl

use Test::More;

eval "use Test::Pod::Coverage 1.08";
plan skip_all => "Test::Pod::Coverage 1.08 required for testing POD coverage"
  if $@;

eval "use Pod::Coverage::TrustPod";
plan skip_all => "Pod::Coverage::TrustPod required for testing POD coverage"
  if $@;

all_pod_coverage_ok({ coverage_class => 'Pod::Coverage::TrustPod' });

___[ xt/release/pod-syntax.t ]___
#!perl
use Test::More;

eval "use Test::Pod 1.00";
plan skip_all => "Test::Pod 1.00 required for testing POD" if $@;

all_pod_files_ok();
