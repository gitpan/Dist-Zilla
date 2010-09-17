package Dist::Zilla::Plugin::PkgDist;
BEGIN {
  $Dist::Zilla::Plugin::PkgDist::VERSION = '4.102341';
}
# ABSTRACT: add a $DIST to your packages
use Moose;
with(
  'Dist::Zilla::Role::FileMunger',
  'Dist::Zilla::Role::FileFinderUser' => {
    default_finders => [ ':InstallModules', ':ExecFiles' ],
  },
);

use PPI;


sub munge_files {
  my ($self) = @_;

  $self->munge_file($_) for @{ $self->found_files };
}

sub munge_file {
  my ($self, $file) = @_;

  # XXX: for test purposes, for now! evil! -- rjbs, 2010-03-17
  return                          if $file->name    =~ /^corpus\//;

  return                          if $file->name    =~ /\.t$/i;
  return $self->munge_perl($file) if $file->name    =~ /\.(?:pm|pl)$/i;
  return $self->munge_perl($file) if $file->content =~ /^#!(?:.*)perl(?:$|\s)/;
  return;
}

sub munge_perl {
  my ($self, $file) = @_;

  my $dist_name = $self->zilla->name;

  my $content = $file->content;

  my $document = PPI::Document->new(\$content)
    or Carp::croak( PPI::Document->errstr );

  {
    # This is sort of stupid.  We want to see if we assign to $DIST already.
    # I'm sure there's got to be a better way to do this, but what the heck --
    # this should work and isn't too slow for me. -- rjbs, 2009-11-29
    my $code_only = $document->clone;
    $code_only->prune("PPI::Token::$_") for qw(Comment Pod Quote Regexp);
    if ($code_only->serialize =~ /\$DIST\s*=/sm) {
      $self->log([ 'skipping %s: assigns to $DIST', $file->name ]);
      return;
    }
  }

  return unless my $package_stmts = $document->find('PPI::Statement::Package');

  my %seen_pkg;

  for my $stmt (@$package_stmts) {
    my $package = $stmt->namespace;

    if ($seen_pkg{ $package }++) {
      $self->log([ 'skipping package re-declaration for %s', $package ]);
      next;
    }

    if ($stmt->content =~ /package\s*\n\s*\Q$package/) {
      $self->log([ 'skipping private package %s', $package ]);
      next;
    }

    # the \x20 hack is here so that when we scan *this* document we don't find
    # an assignment to version; it shouldn't be needed, but it's been annoying
    # enough in the past that I'm keeping it here until tests are better
    my $perl = "BEGIN {\n  \$$package\::DIST\x20=\x20'$dist_name';\n}\n";

    my $dist_doc = PPI::Document->new(\$perl);
    my @children = $dist_doc->schildren;

    $self->log_debug([
      'adding $DIST assignment to %s in %s',
      $package,
      $file->name,
    ]);

    Carp::carp('error inserting $DIST in ' . $file->name)
      unless $stmt->insert_after($children[0]->clone)
      and    $stmt->insert_after( PPI::Token::Whitespace->new("\n") );
  }

  $file->content($document->serialize);
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Plugin::PkgDist - add a $DIST to your packages

=head1 VERSION

version 4.102341

=head1 DESCRIPTION

This plugin will add a line like the following to each package in each Perl
module or program (more or less) within the distribution:

  { our $DIST = 'My-CPAN-Dist'; } # where 'My-CPAN-Dist' is your dist name

It will skip any package declaration that includes a newline between the
C<package> keyword and the package name, like:

  package
    Foo::Bar;

This sort of declaration is also ignored by the CPAN toolchain, and is
typically used when doing monkey patching or other tricky things.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

