package Dist::Zilla::Role::EncodingProvider;
{
  $Dist::Zilla::Role::EncodingProvider::VERSION = '5.006';
}
# ABSTRACT: something that sets a files' encoding
use Moose::Role;
with 'Dist::Zilla::Role::Plugin';

use namespace::autoclean;


requires 'set_file_encodings';

1;

__END__

=pod

=head1 NAME

Dist::Zilla::Role::EncodingProvider - something that sets a files' encoding

=head1 VERSION

version 5.006

=head1 DESCRIPTION

EncodingProvider plugins do their work after files are gathered, but before
they're munged.  They're meant to set the C<encoding> on files.

The method C<set_file_encodings> is called with no arguments.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
