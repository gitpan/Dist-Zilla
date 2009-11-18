package Dist::Zilla::Plugin::ModuleBuild::Test;
our $VERSION = '1.093220';



# ABSTRACT: TestRunner for ModuleBuild based Dists

# $Id:$
use Moose;
use namespace::autoclean;
with 'Dist::Zilla::Role::TestRunner';



sub test {
  my ( $self, $target ) = @_;
  eval {
    ## no critic Punctuation
    system($^X => 'Build.PL') and die "error with Makefile.PL\n";
    system('./Build') and die "error running make\n";
    system('./Build test') and die "error running make test\n";
    1;
  } or return $@;
}

1;


__END__
=pod

=head1 NAME

Dist::Zilla::Plugin::ModuleBuild::Test - TestRunner for ModuleBuild based Dists

=head1 VERSION

version 1.093220

=head1 DESCRIPTION

If you're using C<[ModuleBuild]>, this is likely the test-runner you want to use.

=head1 METHODS

=head2 test

  perl Build.PL
  ./Build
  ./Build test

Is more or less what this plugin does.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

