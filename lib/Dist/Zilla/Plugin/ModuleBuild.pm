package Dist::Zilla::Plugin::ModuleBuild;
our $VERSION = '1.007';

# ABSTRACT: build a Build.PL that uses Module::Build
use Moose;
use Moose::Autobox;
with 'Dist::Zilla::Role::InstallTool';
with 'Dist::Zilla::Role::TextTemplate';

use Dist::Zilla::File::InMemory;


my $template = q|
use strict;
use warnings;

use Module::Build;

my $build = Module::Build->new(
  module_name   => '{{ $module_name }}',
  license       => '{{ $dist->license->meta_yml_name }}',
  dist_abstract => "{{ quotemeta($dist->abstract) }}",
  dist_name     => "{{ quotemeta($dist->name) }}",
  dist_author   => [
{{
    $OUT .= q{"} . quotemeta($_) . q{",} for @{ $dist->authors };
    chomp $OUT;
    return '';
}}
  ],
  requires      => {
{{
    my $prereq = $dist->prereq;
    $OUT .= qq{    "$_" => '$prereq->{$_}',\n} for keys %$prereq;
    chomp $OUT;
    return '';
}}
  },
  script_files => [ qw({{ $exe_files }}) ],
);

$build->create_build_script;
|;

#  module_name   => "{{ quotemeta(
#    (sort {length $a <=> length $b}
#     grep { m{^lib/.+\.pm$} } @{$dist->files})[0]
#  ) }}",

sub setup_installer {
  my ($self, $arg) = @_;
  
  Carp::croak("can't build a Build.PL; license has no known META.yml value")
    unless $self->zilla->license->meta_yml_name;

  (my $name = $self->zilla->name) =~ s/-/::/g;

  my $exe_files = $self->zilla->files
                ->grep(sub { ($_->install_type||'') eq 'bin' })
                ->map(sub { $_->name })
                ->join(' ');

  my $content = $self->fill_in_string(
    $template,
    {
      module_name => $name,
      dist        => \$self->zilla,
      exe_files   => \$exe_files,
    },
  );

  my $file = Dist::Zilla::File::InMemory->new({
    name    => 'Build.PL',
    content => $content,
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

Dist::Zilla::Plugin::ModuleBuild - build a Build.PL that uses Module::Build

=head1 VERSION

version 1.007

=head1 DESCRIPTION

This plugin will create a F<Build.PL> for installing the dist using
L<Module::Build>.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


