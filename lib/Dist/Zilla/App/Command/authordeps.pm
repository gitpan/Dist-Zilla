use strict;
use warnings;
package Dist::Zilla::App::Command::authordeps;
BEGIN {
  $Dist::Zilla::App::Command::authordeps::VERSION = '4.200000';
}
use Dist::Zilla::App -command;
# ABSTRACT: List your distribution's author dependencies

use Dist::Zilla::Util ();
use Moose;
use Path::Class qw(dir);
use List::MoreUtils qw(uniq);
use Config::INI::Reader;

use namespace::autoclean;

sub abstract { "list your distribution's author dependencies" }

sub opt_spec {
  return (
    [ 'root=s' => 'the root of the dist; defaults to .' ],
    [ 'missing' => 'list only the missing dependencies' ],
  );
}

sub execute {
  my ($self, $opt, $arg) = @_;

  $self->log(
    $self->format_author_deps(
      $self->extract_author_deps(
        dir(defined $opt->root ? $opt->root : '.'),
        $opt->missing,
      ),
    ),
  );

  return;
}

sub format_author_deps {
  my ($self, @deps) = @_;
  return join qq{\n} => @deps;
}

sub extract_author_deps {
  my ($self, $root, $missing) = @_;

  my $ini = $root->file('dist.ini');

  die "dzil authordeps only works on dist.ini files, and you don't have one\n"
    unless -e $ini;

  my $fh     = $ini->openr;
  my $config = Config::INI::Reader->read_handle($fh);

  my @sections = uniq map  { s/\s.*//; $_ }
                      grep { $_ ne '_' }
                      keys %{$config};

  return
    grep { $missing ? (! eval "require $_; 1;") : 1 }
    map {; Dist::Zilla::Util->expand_config_package_name($_) } @sections;
}

1;

__END__
=pod

=head1 NAME

Dist::Zilla::App::Command::authordeps - List your distribution's author dependencies

=head1 VERSION

version 4.200000

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

