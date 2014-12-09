package Dist::Zilla::Plugin::MetaYAML;
# ABSTRACT: produce a META.yml
$Dist::Zilla::Plugin::MetaYAML::VERSION = '5.027';
use Moose;
with 'Dist::Zilla::Role::FileGatherer';

use Try::Tiny;
use namespace::autoclean;

#pod =head1 DESCRIPTION
#pod
#pod This plugin will add a F<META.yml> file to the distribution.
#pod
#pod For more information on this file, see L<Module::Build::API> and L<CPAN::Meta>.
#pod
#pod =attr filename
#pod
#pod If given, parameter allows you to specify an alternate name for the generated
#pod file.  It defaults, of course, to F<META.yml>.
#pod
#pod =cut

has filename => (
  is  => 'ro',
  isa => 'Str',
  default => 'META.yml',
);

#pod =attr version
#pod
#pod This parameter lets you pick what version of the spec to use when generating
#pod the output.  It defaults to 1.4, the most commonly supported version at
#pod present.
#pod
#pod B<This may change without notice in the future.>
#pod
#pod Once version 2 of the META file spec is more widely supported, this may default
#pod to 2.
#pod
#pod =cut

has version => (
  is  => 'ro',
  isa => 'Num',
  default => '1.4',
);

sub gather_files {
  my ($self, $arg) = @_;

  require Dist::Zilla::File::FromCode;
  require YAML::Tiny;
  require CPAN::Meta::Converter;
  CPAN::Meta::Converter->VERSION(2.101550); # improved downconversion
  require CPAN::Meta::Validator;
  CPAN::Meta::Validator->VERSION(2.101550); # improved downconversion

  my $zilla = $self->zilla;

  my $file  = Dist::Zilla::File::FromCode->new({
    name => $self->filename,
    code_return_type => 'text',
    code => sub {
      my $distmeta  = $zilla->distmeta;

      my $validator = CPAN::Meta::Validator->new($distmeta);

      unless ($validator->is_valid) {
        my $msg = "Invalid META structure.  Errors found:\n";
        $msg .= join( "\n", $validator->errors );
        $self->log_fatal($msg);
      }

      my $converter = CPAN::Meta::Converter->new($distmeta);
      my $output    = $converter->convert(version => $self->version);
      my $yaml = try {
        YAML::Tiny->new($output)->write_string; # text!
      }
      catch {
        $self->log_fatal("Could not create YAML string: " . YAML::Tiny->errstr)
      };
      return $yaml;
    },
  });

  $self->add_file($file);
  return;
}

__PACKAGE__->meta->make_immutable;
1;

#pod =head1 SEE ALSO
#pod
#pod Core Dist::Zilla plugins:
#pod L<@Basic|Dist::Zilla::PluginBundle::Basic>,
#pod L<Manifest|Dist::Zilla::Plugin::Manifest>.
#pod
#pod Dist::Zilla roles:
#pod L<FileGatherer|Dist::Zilla::Role::FileGatherer>.
#pod
#pod Other modules:
#pod L<CPAN::Meta>,
#pod L<CPAN::Meta::Spec>, L<YAML>.
#pod
#pod =cut

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Plugin::MetaYAML - produce a META.yml

=head1 VERSION

version 5.027

=head1 DESCRIPTION

This plugin will add a F<META.yml> file to the distribution.

For more information on this file, see L<Module::Build::API> and L<CPAN::Meta>.

=head1 ATTRIBUTES

=head2 filename

If given, parameter allows you to specify an alternate name for the generated
file.  It defaults, of course, to F<META.yml>.

=head2 version

This parameter lets you pick what version of the spec to use when generating
the output.  It defaults to 1.4, the most commonly supported version at
present.

B<This may change without notice in the future.>

Once version 2 of the META file spec is more widely supported, this may default
to 2.

=head1 SEE ALSO

Core Dist::Zilla plugins:
L<@Basic|Dist::Zilla::PluginBundle::Basic>,
L<Manifest|Dist::Zilla::Plugin::Manifest>.

Dist::Zilla roles:
L<FileGatherer|Dist::Zilla::Role::FileGatherer>.

Other modules:
L<CPAN::Meta>,
L<CPAN::Meta::Spec>, L<YAML>.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
