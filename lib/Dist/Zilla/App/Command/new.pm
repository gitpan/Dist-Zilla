use strict;
use warnings;
package Dist::Zilla::App::Command::new;
BEGIN {
  $Dist::Zilla::App::Command::new::VERSION = '2.101290';
}
# ABSTRACT: start a new dist
use Dist::Zilla::App -command;


use Dist::Zilla::Types qw(DistName);
use Moose::Autobox;
use Path::Class;

sub abstract { 'start a new dist' }

sub validate_args {
  my ($self, $opt, $args) = @_;

  $self->usage_error('dzil new takes exactly one argument') if @$args != 1;

  my $name = $args->[0];

  $self->usage_error("$name is not a valid distribution name")
    unless is_DistName($args->[0]);
}

sub opt_spec {
  [ 'profile|p=s', 'name of the profile to use', { default => 'default' } ],
  # [ 'module|m=s@', 'module(s) to create; may be given many times'         ],
}

sub execute {
  my ($self, $opt, $arg) = @_;

  my $dist = $arg->[0];

  require Dist::Zilla;
  my $minter = Dist::Zilla->_new_from_profile(
    $opt->profile => {
      chrome  => $self->app->chrome,
      name    => $dist,
    },
  );

  $minter->mint_dist({
    # modules => $opt->module,
  });
}

1;

__END__
=pod

=head1 NAME

Dist::Zilla::App::Command::new - start a new dist

=head1 VERSION

version 2.101290

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

