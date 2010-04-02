package Dist::Zilla::Plugin::TestRelease;
BEGIN {
  $Dist::Zilla::Plugin::TestRelease::VERSION = '2.100922';
}
use Moose;
with 'Dist::Zilla::Role::BeforeRelease';

use Archive::Tar;
use File::chdir ();
use Moose::Autobox;
use Path::Class ();

sub before_release {
  my ($self, $tgz) = @_;
  $tgz = $tgz->absolute;

  my $build_root = $self->zilla->root->subdir('.build');
  $build_root->mkpath unless -d $build_root;

  my $tmpdir = Path::Class::dir( File::Temp::tempdir(DIR => $build_root) );

  $self->log("Extracting $tgz to $tmpdir");

  my @files = do {
    local $File::chdir::CWD = $tmpdir;
    Archive::Tar->extract_archive("$tgz");
  };

  $self->log_fatal([ "Failed to extract archive: %s", Archive::Tar->error ])
    unless @files;

  # Run tests on the extracted tarball:
  my $target = $tmpdir->subdir($files[0]); # Should be the root of the tarball

  local $ENV{RELEASE_TESTING} = 1;
  $self->zilla->run_tests_in($target);

  $self->log("all's well; removing $tmpdir");
  $tmpdir->rmtree;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Plugin::TestRelease

=head1 VERSION

version 2.100922

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

