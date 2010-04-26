use strict;
use warnings;
package Dist::Zilla::App::Command::new;
BEGIN {
  $Dist::Zilla::App::Command::new::VERSION = '2.101160';
}
# ABSTRACT: start a new dist
use Dist::Zilla::App -command;


# I wouldn't need this if I properly moosified my commands. -- rjbs, 2008-10-12
use Mixin::ExtraFields -fields => {
  driver  => 'HashGuts',
  id      => undef,
};

use Dist::Zilla::Types qw(ModuleName);
use Moose::Autobox;
use Path::Class;

sub abstract { 'start a new dist' }

sub mvp_aliases         { { author => 'authors' } }
sub mvp_multivalue_args { qw(authors) }

sub validate_args {
  my ($self, $opt, $args) = @_;

  $self->usage_error('dzil new takes exactly one argument') if @$args != 1;

  my $name = $args->[0];

  $self->usage_error("$name is not a valid module name")
    unless is_ModuleName($args->[0]);
}

sub opt_spec {
}

sub execute {
  my ($self, $opt, $arg) = @_;

  (my $dist = $arg->[0]) =~ s/::/-/g;

  $self->log([
    'dzil new does nothing; if it did something, it would have created %s',
    $dist,
  ]);
}

1;

__END__
=pod

=head1 NAME

Dist::Zilla::App::Command::new - start a new dist

=head1 VERSION

version 2.101160

=head1 SYNOPSIS

Creates a new Dist-Zilla based distribution under the current directory.

  $ dzil new Main::Module::Name

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

