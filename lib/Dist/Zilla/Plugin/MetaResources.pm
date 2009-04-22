package Dist::Zilla::Plugin::MetaResources;
our $VERSION = '1.007';

# ABSTRACT: provide arbitrary "resources" for distribution metadata
use Moose;
with 'Dist::Zilla::Role::MetaProvider';


has resources => (
  is       => 'ro',
  isa      => 'HashRef',
  required => 1,
);

sub new {
  my ($class, $arg) = @_;

  my $self = $class->SUPER::new({
    '=name'   => delete $arg->{'=name'},
    zilla     => delete $arg->{zilla},
    resources => $arg,
  });
}

sub metadata {
  my ($self) = @_;

  return { resources => $self->resources };
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Plugin::MetaResources - provide arbitrary "resources" for distribution metadata

=head1 VERSION

version 1.007

=head1 DESCRIPTION

This plugin adds resources entries to the distribution's metadata.

    [MetaResources]
    homepage: http://example.com/~dude/project.asp

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


