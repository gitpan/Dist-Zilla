package Dist::Zilla::Role::MutableFile;
{
  $Dist::Zilla::Role::MutableFile::VERSION = '5.000'; # TRIAL
}
# ABSTRACT: something that can act like a file with changeable contents
use Moose::Role;

use Moose::Util::TypeConstraints;
use MooseX::SetOnce;
use namespace::autoclean;


with 'Dist::Zilla::Role::File';

sub encoding;

has encoding => (
  is          => 'rw',
  isa         => 'Str',
  lazy        => 1,
  default     => 'UTF-8',
  traits      => [ qw(SetOnce) ],
);


has _content => (
  is          => 'rw',
  isa         => 'Str',
  lazy        => 1,
  builder     => '_build_content',
  clearer     => 'clear_content',
  predicate   => 'has_content',
);

sub content {
  my $self = shift;
  if ( ! @_ ) {
    # if we have it or we're tasked to provide it, return it (possibly lazily
    # generated from a builder); otherwise, get it from the encoded_content
    if ( $self->has_content || $self->_content_source eq 'content' ) {
      return $self->_content;
    }
    else {
      return $self->_content($self->_decode($self->encoded_content));
    }
  }
  else {
    my ($pkg, undef, $line) = caller;
    $self->_update_by('content', sprintf( "%s line %s", $pkg, $line));
    $self->clear_encoded_content;
    return $self->_content(@_);
  }
}


has _encoded_content => (
  is          => 'rw',
  isa         => 'Str',
  lazy        => 1,
  builder     => '_build_encoded_content',
  clearer     => 'clear_encoded_content',
  predicate   => 'has_encoded_content',
);

sub encoded_content {
  my $self = shift;
  if ( ! @_ ) {
    # if we have it or we're tasked to provide it, return it (possibly lazily
    # generated from a builder); otherwise, get it from the content
    if ($self->has_encoded_content || $self->_content_source eq 'encoded_content') {
      return $self->_encoded_content;
    }
    else {
      return $self->_encoded_content($self->_encode($self->content));
    }
  }
  my ($pkg, undef, $line) = caller;
  $self->_update_by('encoded_content', sprintf( "%s line %s", $pkg, $line));
  $self->clear_content;
  $self->_encoded_content(@_);
}

has _content_source => (
    is => 'rw',
    isa => enum([qw/content encoded_content/]),
    lazy => 1,
    builder => '_build_content_source',
);

sub _update_by {
    my ($self, $attr, $from) = @_;
    $self->_content_source($attr);
    $self->_set_added_by($from);
}

around 'added_by' => sub {
    my ($orig, $self) = @_;
    return sprintf("%s set by %s", $self->_content_source, $self->$orig);
};

# we really only need one of these and only if _content or _encoded_content
# isn't provided, but roles can't do that, so we'll insist on both just in case
# and let classes provide stubs if they provide _content or _encoded_content
# another way

requires '_build_content';
requires '_build_encoded_content';

# we need to know the content source so we know where we might need to rely on
# lazy loading to give us content. It should be set by the class if there is a
# class-wide default or just stubbed if a BUILD modifier sets it per-object.

requires '_build_content_source';

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Role::MutableFile - something that can act like a file with changeable contents

=head1 VERSION

version 5.000

=head1 DESCRIPTION

This role describes a file whose contents may be modified

=head1 ATTRIBUTES

=head2 encoding

Default is 'UTF-8'. Can only be set once.

=head2 content

=head2 encoded_content

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
