package Dist::Zilla::Plugin::FinderCode;
BEGIN {
  $Dist::Zilla::Plugin::FinderCode::VERSION = '2.101290';
}
use Moose;
with 'Dist::Zilla::Role::FileFinder';
# ABSTRACT: a callback-based FileFinder plugin

use Moose::Autobox;
use Moose::Util::TypeConstraints;
use namespace::autoclean;

has code => (
  is  => 'ro',
  isa => 'CodeRef',
  required => 1,
);

has style => (
  is  => 'ro',
  isa => enum([ qw(grep list) ]),
  required => 1,
);

sub find_files {
  my ($self) = @_;

  my $method = '_find_via_' . $self->style;

  $self->$method;
}

sub _find_via_grep {
  my ($self) = @_;

  $self->zilla->files->grep($self->code);
}

sub _find_via_list {
  my ($self) = @_;

  my $code = $self->code;
  $self->$code;
}

1;

__END__
=pod

=head1 NAME

Dist::Zilla::Plugin::FinderCode - a callback-based FileFinder plugin

=head1 VERSION

version 2.101290

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

