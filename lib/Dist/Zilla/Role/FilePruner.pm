package Dist::Zilla::Role::FilePruner;
BEGIN {
  $Dist::Zilla::Role::FilePruner::VERSION = '4.200008';
}
# ABSTRACT: something that removes found files from the distribution
use Moose::Role;
with 'Dist::Zilla::Role::Plugin';


requires 'prune_files';

no Moose::Role;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Role::FilePruner - something that removes found files from the distribution

=head1 VERSION

version 4.200008

=head1 DESCRIPTION

Plugins implementing FilePruner have their C<prune_files> method called once
all the L<FileGatherer|Dist::Zilla::Role::FileGatherer> plugins have been
called.  They are expected to (optionally) remove files from the list of files
to be included in the distribution.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

