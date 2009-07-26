package Dist::Zilla::Plugin::UploadToCPAN;
our $VERSION = '1.092071';

# ABSTRACT: upload the dist to CPAN
use Moose;
with 'Dist::Zilla::Role::Releaser';


use CPAN::Uploader;

has user => (
  is   => 'ro',
  isa  => 'Str',
  lazy => 1,
  required => 1,
  default  => sub {
    my ($self) = @_;
    return unless my $app = $self->zilla->dzil_app;
    $app->config_for('Dist::Zilla::App::Command::release')->{user};
  },
);

has password => (
  is   => 'ro',
  isa  => 'Str',
  lazy => 1,
  required => 1,
  default  => sub {
    my ($self) = @_;
    return unless my $app = $self->zilla->dzil_app;
    $app->config_for('Dist::Zilla::App::Command::release')->{password};
  },
);

sub release {
  my ($self, $archive) = @_;

  my $user     = $self->user;
  my $password = $self->password;

  CPAN::Uploader->upload_file(
    "$archive",
    {
      user     => $user,
      password => $password,
    },
  );
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Plugin::UploadToCPAN - upload the dist to CPAN

=head1 VERSION

version 1.092071

=head1 SYNOPSIS

If loaded, this plugin will allow the F<release> command to upload to the CPAN.

=head1 DESCRIPTION

This plugin requires configuration in your C<dist.ini> or C<~/.dzil/config>:

  [=Dist::Zilla::App::Command::release]
  user     = YOUR-PAUSE-ID
  password = YOUR-PAUSE-PASSWORD

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


