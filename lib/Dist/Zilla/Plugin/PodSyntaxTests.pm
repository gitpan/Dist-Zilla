package Dist::Zilla::Plugin::PodSyntaxTests;
# ABSTRACT: a release test for Pod syntax
$Dist::Zilla::Plugin::PodSyntaxTests::VERSION = '5.027';
use Moose;
extends 'Dist::Zilla::Plugin::InlineFiles';
with 'Dist::Zilla::Role::PrereqSource';

use namespace::autoclean;

#pod =head1 DESCRIPTION
#pod
#pod This is an extension of L<Dist::Zilla::Plugin::InlineFiles>, providing the
#pod following files:
#pod
#pod   xt/release/pod-syntax.t   - a standard Test::Pod test
#pod
#pod L<Test::Pod> C<1.41> will be added as a C<develop requires> dependency.
#pod
#pod =cut


# Register the release test prereq as a "develop requires"
# so it will be listed in "dzil listdeps --author"
sub register_prereqs {
  my ($self) = @_;

  $self->zilla->register_prereqs(
    {
      type  => 'requires',
      phase => 'develop',
    },
    'Test::Pod' => '1.41',
  );
}


__PACKAGE__->meta->make_immutable;
1;

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Plugin::PodSyntaxTests - a release test for Pod syntax

=head1 VERSION

version 5.027

=head1 DESCRIPTION

This is an extension of L<Dist::Zilla::Plugin::InlineFiles>, providing the
following files:

  xt/release/pod-syntax.t   - a standard Test::Pod test

L<Test::Pod> C<1.41> will be added as a C<develop requires> dependency.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

__DATA__
___[ xt/release/pod-syntax.t ]___
#!perl
# This file was automatically generated by Dist::Zilla::Plugin::PodSyntaxTests.
use Test::More;
use Test::Pod 1.41;

all_pod_files_ok();
