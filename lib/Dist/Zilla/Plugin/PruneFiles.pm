package Dist::Zilla::Plugin::PruneFiles;
BEGIN {
  $Dist::Zilla::Plugin::PruneFiles::VERSION = '4.102221';
}
# ABSTRACT: prune arbirary files from the dist
use Moose;
use Moose::Autobox;
with 'Dist::Zilla::Role::FilePruner';


sub mvp_multivalue_args { qw(filenames) }
sub mvp_aliases { return { filename => 'filenames' } }


has filenames => (
  is   => 'ro',
  isa  => 'ArrayRef',
  required => 1,
);

sub prune_files {
  my ($self) = @_;

  my %file = map {; $_->name => $_ } $self->zilla->files->flatten;

  for my $exclude ($self->filenames->flatten) {
    for my $name (keys %file) {
      next unless $name eq $exclude || $name =~ m{\A\Q$exclude\E/};

      $self->log_debug([ 'pruning %s', $name ]);

      $self->zilla->prune_file($file{$name});
    }
  }

  return;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Plugin::PruneFiles - prune arbirary files from the dist

=head1 VERSION

version 4.102221

=head1 SYNOPSIS

This plugin allows you to specify filenames to explicitly prune from your
distribution.  This is useful if another plugin (maybe a FileGatherer) adds a
bunch of files, and you only want a subset of them.

In your F<dist.ini>:

  [PruneFiles]
  filenames = xt/release/pod-coverage.t ; pod coverage tests are for jerks

=head1 ATTRIBUTES

=head2 filenames

This is an arrayref of filenames to be pruned from the distribution.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

