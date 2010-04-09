package Dist::Zilla::Config;
use Moose::Role;
# ABSTRACT: stored configuration loader role

use Config::MVP 0.100780; # fix mvp_* method laziness

with q(Config::MVP::Reader) => { -excludes => 'build_assembler' };

use Dist::Zilla::Util::MVPAssembler;


sub build_assembler {
  my $assembler = Dist::Zilla::Util::MVPAssembler->new;

  my $root = $assembler->section_class->new({
    name    => '_',
    aliases => { author => 'authors' },
    multivalue_args => [ qw(authors) ],
  });

  $assembler->sequence->add_section($root);

  return $assembler;
}

no Moose::Role;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Config - stored configuration loader role

=head1 VERSION

version 2.100990

=head1 DESCRIPTION

The config role provides some helpers for writing a configuration loader using
the L<Config::MVP|Config::MVP> system to load and validate its configuration.

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

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

