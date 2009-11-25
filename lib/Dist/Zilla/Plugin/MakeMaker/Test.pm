package Dist::Zilla::Plugin::MakeMaker::Test;
our $VERSION = '1.093290';



# ABSTRACT: TestRunner for MakeMaker based Dists

# $Id:$
use Moose;
use namespace::autoclean;
with 'Dist::Zilla::Role::TestRunner';



sub test {
  my ( $self, $target ) = @_;
  eval {
    ## no critic Punctuation
    system($^X => 'Makefile.PL') and die "error with Makefile.PL\n";
    system('make') and die "error running make\n";
    system('make test') and die "error running make test\n";
    1;
  } or return $@;
}

1;


__END__
=pod

=head1 NAME

Dist::Zilla::Plugin::MakeMaker::Test - TestRunner for MakeMaker based Dists

=head1 VERSION

version 1.093290

=head1 DESCRIPTION

If you're using C<[MakeMaker]>, this is likely the test-runner you want to use.

=head1 METHODS

=head2 test

  perl Makefile.PL
  make
  make test

Is more or less what this plugin does.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

