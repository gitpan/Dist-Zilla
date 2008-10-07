use strict;
use warnings;
package Dist::Zilla::App::Command::test;
our $VERSION = '1.001';

# ABSTRACT: test your dist
use Dist::Zilla::App -command;

sub abstract { 'test your dist' }

sub run {
  my ($self, $opt, $arg) = @_;

  require Dist::Zilla;
  require File::chdir;
  require File::Temp;
  require Path::Class;

  my $build_root = Path::Class::dir('.build');
  $build_root->mkpath unless -d $build_root;

  my $target = Path::Class::dir( File::Temp::tempdir(DIR => $build_root) );
  $self->log("building test distribution under $target");

  local $ENV{AUTHOR_TESTING} = 1;
  local $ENV{RELEASE_TESTING} = 1;

  $self->zilla->ensure_built_in($target);

  eval {
    ## no critic Punctuation
    local $File::chdir::CWD = $target;
    system($^X => 'Makefile.PL') and die "error with Makefile.PL\n";
    system('make') and die "error running make\n";
    system('make test') and die "error running make test\n";
  };

  if ($@) {
    $self->log($@);
    $self->log("left failed dist in place at $target");
  } else {
    $self->log("all's well; removing $target");
    $target->rmtree;
  }
}

1;

__END__

=pod

=head1 NAME

Dist::Zilla::App::Command::test - test your dist

=head1 VERSION

version 1.001

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


