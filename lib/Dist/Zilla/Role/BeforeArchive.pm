package Dist::Zilla::Role::BeforeArchive;
BEGIN {
  $Dist::Zilla::Role::BeforeArchive::VERSION = '4.101582';
}
use Moose::Role;
with 'Dist::Zilla::Role::Plugin';
# ABSTRACT: something that runs before the archive file is built

requires 'before_archive';

no Moose::Role;
1;


=pod

=head1 NAME

Dist::Zilla::Role::BeforeArchive - something that runs before the archive file is built

=head1 VERSION

version 4.101582

=head1 DESCRIPTION

Plugins implementing this role have their C<before_archive> method
called before the archive is actually built.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

