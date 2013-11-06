use strict;
use warnings;

package Dist::Zilla::App::Command::version;
{
  $Dist::Zilla::App::Command::version::VERSION = '5.006';
}
use Dist::Zilla::App -command;
use Moose;
extends 'App::Cmd::Command::version';

# ABSTRACT: display dzil's version


sub version_for_display {
  my $version_pkg = $_[0]->version_package;
  my $version = ( $version_pkg->VERSION ?
                  $version_pkg->VERSION :
                 'dev' );
}

1;

__END__

=pod

=head1 NAME

Dist::Zilla::App::Command::version - display dzil's version

=head1 VERSION

version 5.006

=head1 SYNOPSIS

Print dzil version

  $ dzil --version or $dzil version

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
