package Dist::Zilla::Plugin::InstallDirs;
our $VERSION = '1.100630';
# ABSTRACT: mark directory contents for installation
use Moose;
with 'Dist::Zilla::Role::Plugin';
use Moose::Autobox;


sub mvp_multivalue_args { qw(bin share) }

has bin => (
  is   => 'ro',
  isa  => 'ArrayRef[Str]',
  lazy => 1,
  default => sub { [ qw(bin) ] },
);

has share => (
  is   => 'ro',
  isa  => 'ArrayRef[Str]',
  lazy => 1,
  default => sub {
    my ($self) = @_;
    if ($self->zilla->files->grep(sub { $_->name =~ m{\Ashare/} })->length) {
      return [ qw(share) ];
    } else {
      return [];
    }
  },
);

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Plugin::InstallDirs - mark directory contents for installation

=head1 VERSION

version 1.100630

=head1 SYNOPSIS

In your F<dist.ini>:

  [InstallDirs]
  bin = scripts
  bin = extra_scripts

=head1 DESCRIPTION

This plugin marks the contents of certain directories as files to be installed
under special locations.

C<bin> indicates directories that contain executable files to install.  If no
value is given, the directory C<bin> will be used.

C<share> indicates directories that contain shared content to install for use
with L<File::ShareDir>.  If no value is given, it will try to guess whether or
not F<./share> should be used.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

