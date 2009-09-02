package Dist::Zilla::Config::INI;
our $VERSION = '1.092450';

use Moose;
with qw(
  Dist::Zilla::Config
  Dist::Zilla::ConfigRole::Findable
);
# ABSTRACT: the reader for dist.ini files

use Config::INI::MVP::Reader;


# Clearly this should be an attribute with a builder blah blah blah. -- rjbs,
# 2009-07-25
sub default_extension { 'ini' }

sub read_config {
  my ($self, $arg) = @_;
  my $config_file = $self->filename_from_args($arg);

  my $ini = Config::INI::MVP::Reader->new({ assembler => $self->assembler });
  $ini->read_file($config_file);

  # should be done in CIMR!! -- rjbs, 2009-08-24
  $self->assembler->end_section if $self->assembler->current_section;

  return $self->assembler->sequence;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Config::INI - the reader for dist.ini files

=head1 VERSION

version 1.092450

=head1 DESCRIPTION

Dist::Zilla::Config reads in the F<dist.ini> file for a distribution.  It uses
L<Config::INI::MVP::Reader> to do most of the heavy lifting, using the helpers
set up in L<Dist::Zilla::Config>.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


