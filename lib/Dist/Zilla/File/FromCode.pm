package Dist::Zilla::File::FromCode;
{
  $Dist::Zilla::File::FromCode::VERSION = '5.000'; # TRIAL
}
# ABSTRACT: a file whose content is (re-)built on demand
use Moose;
use Moose::Util::TypeConstraints;

use namespace::autoclean;


has code => (
  is  => 'rw',
  isa => 'CodeRef|Str',
  required => 1,
);


has code_return_type => (
  is => 'ro',
  isa => enum([ qw(text bytes) ]),
  default => 'text',
);


has encoding => (
    is => 'ro',
    isa => 'Str',
    default => 'UTF-8',
);


sub content {
  my ($self) = @_;

  confess("cannot set content of a FromCode file") if @_ > 1;

  my $code = $self->code;
  my $result = $self->$code;

  if ( $self->code_return_type eq 'text' ) {
    return $result;
  }
  else {
    $self->_decode($result);
  }
}


sub encoded_content {
  my ($self) = @_;

  confess( "cannot set encoded_content of a FromCode file" ) if @_ > 1;

  my $code = $self->code;
  my $result = $self->$code;

  if ( $self->code_return_type eq 'bytes' ) {
    return $result;
  }
  else {
    $self->_encode($result);
  }
}


with 'Dist::Zilla::Role::File';
__PACKAGE__->meta->make_immutable;
1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::File::FromCode - a file whose content is (re-)built on demand

=head1 VERSION

version 5.000

=head1 DESCRIPTION

This represents a file whose contents will be generated on demand from a
callback or method name.

It has one attribute, C<code>, which may be a method name (string) or a
coderef.  When the file's C<content> method is called, the code is used to
generate the content.  This content is I<not> cached.  It is recomputed every
time the content is requested.

=head1 ATTRIBUTES

=head2 code_return_type

'text' or 'bytes'

=head2 encoding

=head2 content

=head2 encoded_content

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
