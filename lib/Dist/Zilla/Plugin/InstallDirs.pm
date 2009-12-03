package Dist::Zilla::Plugin::InstallDirs;
our $VERSION = '1.093370';
# ABSTRACT: mark directory contents for installation
use Moose;
use Moose::Autobox;
with 'Dist::Zilla::Role::FileMunger';


# XXX: implement share -- rjbs, 2008-06-08
sub mvp_multivalue_args { qw(bin share) }

has mark_as_bin => (
  is   => 'ro',
  isa  => 'ArrayRef[Str]',
  default  => sub { [ qw(bin) ] },
  init_arg => 'bin'
);

sub munge_file {
  my ($self, $file) = @_;

  for my $dir ($self->mark_as_bin->flatten) {
    next unless $file->name =~ qr{^\Q$dir\E[\\/]};
    $file->install_type('bin');
  }
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Plugin::InstallDirs - mark directory contents for installation

=head1 VERSION

version 1.093370

=head1 SYNOPSIS

In your F<dist.ini>:

  [InstallDirs]
  bin = scripts
  bin = extra_scripts

=head1 DESCRIPTION

This plugin marks the contents of certain directories as files to be installed
under special locations.

The only implemented attribute is C<bin>, which indicates directories that
contain executable files to install.  If no value is given, the directory
C<bin> will be considered.

=head1 TODO

Add support for ShareDir-style C<dist_dir> files.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

