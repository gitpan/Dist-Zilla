package Dist::Zilla::Plugin::Encoding;
{
  $Dist::Zilla::Plugin::Encoding::VERSION = '5.006';
}
# ABSTRACT: set the encoding of arbitrary files
use Moose;
with 'Dist::Zilla::Role::EncodingProvider';

use namespace::autoclean;


sub mvp_multivalue_args { qw(filenames matches) }
sub mvp_aliases { return { filename => 'filenames', match => 'matches' } }


has encoding => (
  is   => 'ro',
  isa  => 'Str',
  required => 1,
);


has filenames => (
  is   => 'ro',
  isa  => 'ArrayRef',
  default => sub { [] },
);


has matches => (
  is   => 'ro',
  isa  => 'ArrayRef',
  default => sub { [] },
);

sub set_file_encodings {
  my ($self) = @_;

  # never match (at least the filename characters)
  my $matches_regex = qr/\000/;

  $matches_regex = qr/$matches_regex|$_/ for @{$self->matches};

  # \A\Q$_\E should also handle the `eq` check
  $matches_regex = qr/$matches_regex|\A\Q$_\E/ for @{$self->filenames};

  for my $file (@{$self->zilla->files}) {
    next unless $file->name =~ $matches_regex;

    $self->log_debug([
      'setting encoding of %s to %s',
      $file->name,
      $self->encoding,
    ]);

    $file->encoding($self->encoding);
  }

  return;
}

__PACKAGE__->meta->make_immutable;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Plugin::Encoding - set the encoding of arbitrary files

=head1 VERSION

version 5.006

=head1 SYNOPSIS

This plugin allows you to explicitly set the encoding on some files in your
distribution. You can either specify the exact set of files (with the
"filenames" parameter) or provide the regular expressions to check (using
"match").

In your F<dist.ini>:

  [Encoding]
  encoding = Latin-3

  filename = t/esperanto.t  ; this file is Esperanto
  match     = ^t/urkish/    ; these are all Turkish

=head1 ATTRIBUTES

=head2 encoding

This is the encoding to set on the selected files.

=head2 filenames

This is an arrayref of filenames to have their encoding set.

=head2 matches

This is an arrayref of regular expressions.  Any file whose name matches one of
these regex will have its encoding set.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
