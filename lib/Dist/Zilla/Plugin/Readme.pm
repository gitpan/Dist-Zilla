package Dist::Zilla::Plugin::Readme;
BEGIN {
  $Dist::Zilla::Plugin::Readme::VERSION = '2.100991';
}
# ABSTRACT: build a README file
use Moose;
use Moose::Autobox;
with 'Dist::Zilla::Role::FileGatherer';
with 'Dist::Zilla::Role::TextTemplate';


sub gather_files {
  my ($self, $arg) = @_;

  require Dist::Zilla::File::InMemory;

  my $template = q|

This archive contains the distribution {{ $dist->name }},
version {{ $dist->version }}:

  {{ $dist->abstract }}

{{ $dist->license->notice }}

|;

  my $content = $self->fill_in_string(
    $template,
    { dist => \($self->zilla) },
  );

  my $file = Dist::Zilla::File::InMemory->new({
    content => $content,
    name    => 'README',
  });

  $self->add_file($file);
  return;
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Plugin::Readme - build a README file

=head1 VERSION

version 2.100991

=head1 DESCRIPTION

This plugin adds a very simple F<README> file to the distribution, citing the
dist's name, version, abstract, and license.  It may be more useful or
informative in the future.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

