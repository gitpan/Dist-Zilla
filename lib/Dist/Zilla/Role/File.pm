package Dist::Zilla::Role::File;
our $VERSION = '1.092310';

# ABSTRACT: something that can act like a file
use Moose::Role;


has name => (
  is   => 'rw',
  isa  => 'Str', # Path::Class::File?
  required => 1,
);


has added_by => (
  is => 'ro',
);


has install_type => (
  is => 'rw',
);

# Why didn't this work with 0.65? :( -- rjbs, 2009-04-20
# requires 'content';

no Moose::Role;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Role::File - something that can act like a file

=head1 VERSION

version 1.092310

=head1 DESCRIPTION

This role describes a file that may be written into the shipped distribution.

=head1 ATTRIBUTES

=head2 name

This is the name of the file to be written out.

=head2 added_by

This is a string describing when and why the file was added to the
distribution.  It will generally be set by a plugin implementing the
L<FileInjector|Dist::Zilla::Role::FileInjector> role.

=head2 install_type

This attribute may be set to something indicating where the file will be
installed.  For now, its meaning is pretty up in the air.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


