package Dist::Zilla::Plugin::Manifest;
our $VERSION = '1.092070';

# ABSTRACT: build a MANIFEST file
use Moose;
use Moose::Autobox;
with 'Dist::Zilla::Role::InstallTool';


sub setup_installer {
  my ($self, $arg) = @_;

  my $file = Dist::Zilla::File::InMemory->new({
    name    => 'MANIFEST',
    content => $self->zilla->files->map(sub{$_->name})->push('MANIFEST')
               ->sort->join("\n"),
  });

  $self->add_file($file);
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Plugin::Manifest - build a MANIFEST file

=head1 VERSION

version 1.092070

=head1 DESCRIPTION

If included, this plugin will produce a F<MANIFEST> file for the distribution,
listing all of the files it contains.  For obvious reasons, it should be
included as close to last as possible.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


