package Dist::Zilla::Plugin::ClearPrereqs;
BEGIN {
  $Dist::Zilla::Plugin::ClearPrereqs::VERSION = '4.101800';
}
# ABSTRACT: a plugin to clear gathered prereqs
use Moose;
with 'Dist::Zilla::Role::PrereqSource';

use Moose::Autobox;

use MooseX::Types::Moose qw(ArrayRef);
use MooseX::Types::Perl  qw(ModuleName);


sub mvp_multivalue_args { qw(modules_to_clear) }

sub mvp_aliases {
  return { clear => 'modules_to_clear' }
}

has modules_to_clear => (
  is  => 'ro',
  isa => ArrayRef[ ModuleName ],
  required => 1,
);

around dump_config => sub {
  my ($orig, $self) = @_;
  my $config = $self->$orig;

  my $this_config = {
    modules_to_clear  => $self->modules_to_clear,
  };

  $config->{'' . __PACKAGE__} = $this_config;

  return $config;
};

my @phases = qw(configure build test runtime develop);
my @types  = qw(requires recommends suggests conflicts);

sub register_prereqs {
  my ($self) = @_;

  my $prereqs = $self->zilla->prereqs;

  for my $p (@phases) {
    for my $t (@types) {
      for my $m ($self->modules_to_clear->flatten) {
        $prereqs->requirements_for($p, $t)->clear_requirement($m);
      }
    }
  }
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Plugin::ClearPrereqs - a plugin to clear gathered prereqs

=head1 VERSION

version 4.101800

=head1 SYNOPSIS

In your F<dist.ini>:

  [ClearPrereq]
  clear = Foo::Bar
  clear = MRO::Compat

This will remove any prerequisite of any type from any prereq phase.  This is
useful for eliminating incorrectly detected prereqs.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

