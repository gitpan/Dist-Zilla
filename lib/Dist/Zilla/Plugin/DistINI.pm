package Dist::Zilla::Plugin::DistINI;
BEGIN {
  $Dist::Zilla::Plugin::DistINI::VERSION = '3.101461';
}
# ABSTRACT: a plugin to add a dist.ini to newly-minted dists
use Moose;
with qw(Dist::Zilla::Role::FileGatherer);

use Dist::Zilla::File::InMemory;


sub gather_files {
  my ($self, $arg) = @_;

  my @core_attrs = qw(name authors copyright_holder);

  my $license = ref $self->zilla->license;
  if ($license =~ /^Software::License::(.+)$/) {
    $license = $1;
  } else {
    $license = "=$license";
  }

  my $content = '';
  $content .= sprintf "name    = %s\n", $self->zilla->name;
  $content .= sprintf "author  = %s\n", $_ for @{ $self->zilla->authors };
  $content .= sprintf "license = %s\n", $license;
  $content .= sprintf "copyright_holder = %s\n", $self->zilla->copyright_holder;
  $content .= sprintf "copyright_year   = %s\n", (localtime)[5] + 1900;
  $content .= "\n";

  my $file = Dist::Zilla::File::InMemory->new({
    name    => "dist.ini",
    content => $content,
  });

  $self->add_file($file);
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Plugin::DistINI - a plugin to add a dist.ini to newly-minted dists

=head1 VERSION

version 3.101461

=head1 DESCRIPTION

This plugins produces a F<dist.ini> file in a new dist, specifying the required
core attributes from the dist being minted.

This plugin is dead simple and pretty stupid, but should get better as dist
minting facilities improve.  For example, it will not specify any plugins.

In the meantime, you may be happier with a F<dist.ini> template.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

