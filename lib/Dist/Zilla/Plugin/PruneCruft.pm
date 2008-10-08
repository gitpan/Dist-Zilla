package Dist::Zilla::Plugin::PruneCruft;
our $VERSION = '1.002';

# ABSTRACT: prune stuff that you probably don't mean to include
use Moose;
use Moose::Autobox;
with 'Dist::Zilla::Role::FilePruner';


# sub multivalue_args { qw(file) }

sub exclude_file {
  my ($self, $file) = @_;

  return 1 if index($file->name, $self->zilla->name . '-') == 0;
  return 1 if $file->name eq 'dist.ini';
  return 1 if $file->name =~ /\A\./;
  return 1 if $file->name =~ /\A(?:Build|Makefile)\z/;
  return;
}

sub prune_files {
  my ($self) = @_;

  my $files = $self->zilla->files;

  @$files = $files->grep(sub { ! $self->exclude_file($_) })->flatten;

  return;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Plugin::PruneCruft - prune stuff that you probably don't mean to include

=head1 VERSION

version 1.002

=head1 SYNOPSIS

This plugin tries to compensate for the stupid crap that turns up in your
working copy, removing it before it gets into your dist and screws everything
up.

In your F<dist.ini>:

    [PruneCruft]

That's it!  Maybe some day there will be a mechanism for excluding exclusions,
but for now that exclusion exclusion mechanism has been excluded.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


