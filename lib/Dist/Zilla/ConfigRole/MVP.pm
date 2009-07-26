package Dist::Zilla::ConfigRole::MVP;
our $VERSION = '1.092070';

use Moose::Role;
# ABSTRACT: something that converts Config::MVP sequences to config structs

use Dist::Zilla::Util::MVPAssembler;


has assembler => (
  is   => 'ro',
  isa  => 'Config::MVP::Assembler',
  lazy => 1,
  default => sub {
    my $assembler = Dist::Zilla::Util::MVPAssembler->new;

    my $root = $assembler->section_class->new({
      name => '_',
      aliases => { author => 'authors' },
      multivalue_args => [ qw(authors) ],
    });

    $assembler->sequence->add_section($root);

    return $assembler;
  }
);

sub config_struct {
  my ($self) = @_;

  my @sections = $self->assembler->sequence->sections;

  my $root_config = (shift @sections)->payload;

  my @plugins;
  for my $section (@sections) {
    my $config = { %{ $section->payload } };
    push @plugins, [ $section->name => $section->package => $config ];
  }

  return ($root_config, \@plugins);
}

no Moose::Role;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::ConfigRole::MVP - something that converts Config::MVP sequences to config structs

=head1 VERSION

version 1.092070

=head1 DESCRIPTION

The MVP config role provides some helpers for writing a configuration loader
that will use the L<Config::MVP|Config::MVP> system to load and validate its
configuration.  (This will probably be most configuration loaders.)

=head1 ATTRIBUTES

=head2 assembler

The L<assembler> attribute must be a Config::MVP::Assembler, has a sensible
default that will handle the standard needs of a config loader.  Namely, it
will be pre-loaded with a starting section for root configuration.  That
starting section will alias C<author> to C<authors> and will set that up as a
multivalue argument.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


