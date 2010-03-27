package Dist::Zilla::Role::ExecFiles;
$Dist::Zilla::Role::ExecFiles::VERSION = '1.100860';
use Moose::Role;
with 'Dist::Zilla::Role::FileFinder';
# something that finds files to install as executables

requires 'dir';

sub find_files {
  my ($self) = @_;

  my $dir = $self->dir;
  my $files = $self->zilla->files->grep(sub { index($_->name, "$dir/") == 0 });
}

1;

__END__
=pod

=head1 NAME

Dist::Zilla::Role::ExecFiles

=head1 VERSION

version 1.100860

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

