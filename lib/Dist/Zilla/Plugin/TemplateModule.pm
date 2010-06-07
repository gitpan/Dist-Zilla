package Dist::Zilla::Plugin::TemplateModule;
BEGIN {
  $Dist::Zilla::Plugin::TemplateModule::VERSION = '4.101582';
}
# ABSTRACT: a simple module-from-template plugin
use Moose;
with qw(Dist::Zilla::Role::ModuleMaker Dist::Zilla::Role::TextTemplate);

use autodie;

use Data::Section 0.004 -setup; # fixed header_re
use Dist::Zilla::File::InMemory;


has template => (
  is  => 'ro',
  isa => 'Str',
  predicate => 'has_template',
);

sub make_module {
  my ($self, $arg) = @_;

  my $template;

  if ($self->has_template) {
    open my $fh, '<', $self->template;
    $template = do { local $/; <$fh> };
  } else {
    $template = ${ $self->section_data('Module.pm') };
  }

  my $content = $self->fill_in_string(
    $template,
    {
      name => $arg->{name},
    },
  );

  (my $filename = $arg->{name}) =~ s{::}{/}g;

  my $file = Dist::Zilla::File::InMemory->new({
    name    => "lib/$filename.pm",
    content => $content,
  });

  $self->add_file($file);
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;


=pod

=head1 NAME

Dist::Zilla::Plugin::TemplateModule - a simple module-from-template plugin

=head1 VERSION

version 4.101582

=head1 DESCRIPTION

This is a L<ModuleMaker|Dist::Zilla::Role::ModuleMaker> used for creating new
Perl modules files when minting a new dist with C<dzil new>.  It uses
L<Text::Template> (via L<Dist::Zilla::Role::TextTemplate>) to render a template
into a Perl module.  The only variable provided to the template is C<$name>,
the module name.  The module is always created as a file under F<./lib>.

By default, the template looks something like this:

  use strict;
  use warnings;
  package {{ $name }};

  1;

=head1 ATTRIBUTES

=head2 template

The C<template> parameter may be given to the plugin to provide a different
filename, absolute or relative to the build root.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__DATA__
__[ Module.pm ]__
use strict;
use warnings;
package {{ $name }};

1;
