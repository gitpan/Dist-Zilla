package Dist::Zilla::MVP::Section;
BEGIN {
  $Dist::Zilla::MVP::Section::VERSION = '4.101740';
}
use Moose;
extends 'Config::MVP::Section';
# ABSTRACT: a standard section in Dist::Zilla's configuration sequence

use Moose::Autobox;

after finalize => sub {
  my ($self) = @_;

  my ($name, $plugin_class, $arg) = (
    $self->name,
    $self->package,
    $self->payload,
  );

  my %payload = %{ $self->payload };

  my %dzil;
  $dzil{$_} = delete $payload{":$_"} for grep { s/\A:// } keys %payload;

  if (defined $dzil{version}) {
    require Version::Requirements;
    my $req = Version::Requirements->from_string_hash({
      $plugin_class => $dzil{version}
    });

    my $version = $plugin_class->VERSION;
    unless ($req->accepts_module($plugin_class => $version)) {
      # $self->assembler->log_fatal([
      confess sprintf
        "%s version (%s) not match required version: %s",
        $plugin_class,
        $version,
        $dzil{version},
      ;
      # ]);
    }
  }

  $plugin_class->register_component($name, $arg, $self);

  return;
};

1;

__END__
=pod

=head1 NAME

Dist::Zilla::MVP::Section - a standard section in Dist::Zilla's configuration sequence

=head1 VERSION

version 4.101740

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

