package Dist::Zilla::Plugin::MetaJSON;
our $VERSION = '1.091370';

# ABSTRACT: produce a META.json
use Moose;
use Moose::Autobox;
with 'Dist::Zilla::Role::FileGatherer';

use Hash::Merge::Simple ();


sub gather_files {
  my ($self, $arg) = @_;

  require Dist::Zilla::File::InMemory;
  require JSON;

  my $meta = {
    name     => $self->zilla->name,
    version  => $self->zilla->version,
    abstract => $self->zilla->abstract,
    author   => $self->zilla->authors,
    license  => $self->zilla->license->meta_yml_name,
    requires => $self->zilla->prereq,
    generated_by => (ref $self) . ' version ' . $self->VERSION,
  };

  $meta = Hash::Merge::Simple::merge($meta, $_->metadata)
    for $self->zilla->plugins_with(-MetaProvider)->flatten;

  my $file = Dist::Zilla::File::InMemory->new({
    name    => 'META.json',
    content => JSON->new->ascii(1)->pretty->encode($meta) . "\n",
  });

  $self->add_file($file);
  return;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Plugin::MetaJSON - produce a META.json

=head1 VERSION

version 1.091370

=head1 DESCRIPTION

This plugin will add a F<META.json> file to the distribution.

This file is meant to replace the old-style F<META.yml>.  For more information
on this file, see L<Module::Build::API> and
L<http://module-build.sourceforge.net/META-spec-v1.3.html>.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


