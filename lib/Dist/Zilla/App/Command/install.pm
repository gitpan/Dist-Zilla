use strict;
use warnings;
package Dist::Zilla::App::Command::install;
our $VERSION = '1.093370';
# ABSTRACT: install your dist
use Dist::Zilla::App -command;

sub abstract { 'install your dist' }


sub opt_spec {
  [ 'install-command=s', 'command to run to install (e.g. "cpan .")' ],
}



sub execute {
  my ($self, $opt, $arg) = @_;

  require File::chdir;
  require File::Temp;
  require Path::Class;

  my $build_root = Path::Class::dir('.build');
  $build_root->mkpath unless -d $build_root;

  my $target = Path::Class::dir( File::Temp::tempdir(DIR => $build_root) );
  $self->log("building distribution under $target for installation");
  $self->zilla->ensure_built_in($target);

  eval {
    ## no critic Punctuation
    local $File::chdir::CWD = $target;
    my @cmd = $opt->{install_command}
            ? $opt->{install_command}
            : ($^X => '-MCPAN' => '-einstall "."');

    system(@cmd) && die "error with '@cmd'\n";
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

Dist::Zilla::App::Command::install - install your dist

=head1 VERSION

version 1.093370

=head1 SYNOPSIS

Installs your distribution using a specified command.

    dzil install [--install-command="cmd"]

=head1 EXAMPLE

    $ dzil install
    $ dzil install --install-command="cpan ."

=head1 OPTIONS

=head2 --install-command

This defines what command to run after building the dist in the dist dir.

Any value that works with L<C<system>|perlfunc/system> is accepted.

If not specified, calls

    perl -MCPAN -einstall "."

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

