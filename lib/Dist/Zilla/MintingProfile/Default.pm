package Dist::Zilla::MintingProfile::Default;
BEGIN {
  $Dist::Zilla::MintingProfile::Default::VERSION = '4.101780';
}
# ABSTRACT: Default minting profile provider
use Moose;
with 'Dist::Zilla::Role::MintingProfile::ShareDir';

use File::ShareDir;
use Path::Class;

use namespace::autoclean;


around profile_dir => sub {
  my ($orig, $self, $profile_name) = @_;

  $profile_name ||= 'default';

  my $profile_dir = dir( File::HomeDir->my_home )
                  ->subdir('.dzil', 'profiles', $profile_name);

  return $profile_dir if -d $profile_dir;

  return $self->$orig($profile_name);
};

1;

__END__
=pod

=head1 NAME

Dist::Zilla::MintingProfile::Default - Default minting profile provider

=head1 VERSION

version 4.101780

=head1 DESCRIPTION

Default minting profile provider.

This provider looks first in the F<~/.dzil/profiles/$profile_name> directory,
if not found it looks among the default profiles shipped with Dist::Zilla.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

