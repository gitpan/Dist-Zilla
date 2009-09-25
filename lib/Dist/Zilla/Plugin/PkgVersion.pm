package Dist::Zilla::Plugin::PkgVersion;
our $VERSION = '1.092680';


# ABSTRACT: add a $VERSION to your packages
use Moose;
with 'Dist::Zilla::Role::FileMunger';


sub munge_file {
  my ($self, $file) = @_;

  return $self->munge_perl($file) if $file->name    =~ /\.(?:pm|pl)$/i;
  return $self->munge_perl($file) if $file->content =~ /^#!(?:.*)perl(?:$|\s)/;
  return;
}

sub munge_perl {
  my ($self, $file) = @_;

  my $content = $file->content;

  require Dist::Zilla::Util;
  my $p = Dist::Zilla::Util::Nonpod->_new;
  $p->read_string($content);
  my $nonpod = $p->_nonpod;

  if ($nonpod =~ /\$VERSION\s*=/) {
    $self->log(sprintf('skipping %s: assigns to $VERSION', $file->name));
    return;
  }

  my $version = $self->zilla->version;
  Carp::croak("invalid characters in version") if $version !~ /\A[.0-9_]+\z/;

  # That \x20 is my OH SO CLEVER way of thwarting the \s* above.
  # -- rjbs, 2008-06-02
  $content =~ s<^([{\t ]*)(package \S+;)([}\t ]*)$>
               <$1$2\nour \$VERSION\x20= '$version';\n$3\n>mg;
  $file->content($content);
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Plugin::PkgVersion - add a $VERSION to your packages

=head1 VERSION

version 1.092680

=head1 DESCRIPTION

This plugin will add a line like the following to each package in each Perl
module or program (more or less) within the distribution:

  our $VERSION = 0.001; # where 0.001 is the version of the dist

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


