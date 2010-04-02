package Dist::Zilla::File::FromCode;
$Dist::Zilla::File::FromCode::VERSION = '2.100920';
# ABSTRACT: a file whose content is (re-)built on demand
use Moose;


has code => (
  is  => 'rw',
  isa => 'CodeRef|Str',
  required => 1,
);

sub content {
  my ($self) = @_;

  my $code = $self->code;
  return $self->$code;
}

with 'Dist::Zilla::Role::File';
__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::File::FromCode - a file whose content is (re-)built on demand

=head1 VERSION

version 2.100920

=head1 DESCRIPTION

This represents a file whose contents will be generated on demand from a
callback or method name.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

