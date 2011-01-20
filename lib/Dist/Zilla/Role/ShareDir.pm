package Dist::Zilla::Role::ShareDir;
BEGIN {
  $Dist::Zilla::Role::ShareDir::VERSION = '4.200001';
}
# ABSTRACT: something that picks a directory to install as shared files
use Moose::Role;
with 'Dist::Zilla::Role::FileFinder';

# Must return a hashref with any of the keys 'dist' and 'module'.  The 'dist'
# must be a scalar with a directory to include and 'module' must be a hashref
# mapping module names to directories to include.  If there are no directories
# to include, it must return undef.
requires 'share_dir_map';

1;

__END__
=pod

=head1 NAME

Dist::Zilla::Role::ShareDir - something that picks a directory to install as shared files

=head1 VERSION

version 4.200001

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

