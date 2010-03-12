package Dist::Zilla::File::OnDisk;
our $VERSION = '1.100710';
# ABSTRACT: a file that comes from your filesystem
use Moose;


has content => (
  is  => 'rw',
  isa => 'Str',
  lazy => 1,
  default => sub { shift->_read_file },
);

has _original_name => (
  is  => 'ro',
  isa => 'Str',
  init_arg => undef,
);

sub BUILD {
  my ($self) = @_;
  $self->{_original_name} = $self->name;
}

sub _read_file {
  my ($self) = @_;

  my $fname = $self->_original_name;
  open my $fh, '<', $fname or die "can't open $fname for reading: $!";
  my $content = do { local $/; <$fh> };
}

with 'Dist::Zilla::Role::File';

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::File::OnDisk - a file that comes from your filesystem

=head1 VERSION

version 1.100710

=head1 DESCRIPTION

This represents a file stored on disk.  Its C<content> attribute is read from
the originally given file name when first read, but is then kept in memory and
may be altered by plugins.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

