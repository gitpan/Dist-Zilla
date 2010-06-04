package Dist::Zilla::MVP::Assembler;
BEGIN {
  $Dist::Zilla::MVP::Assembler::VERSION = '4.101550';
}
use Moose;
extends 'Config::MVP::Assembler';
with 'Config::MVP::Assembler::WithBundles';
# ABSTRACT: Dist::Zilla-specific subclass of Config::MVP::Assembler

use Dist::Zilla::Util;

has chrome => (
  is  => 'rw',
  isa => 'Object', # will be does => 'Dist::Zilla::Role::Chrome' when it exists
  required => 1,
);

has logger => (
  is   => 'ro',
  isa  => 'Log::Dispatchouli::Proxy', # could be duck typed, I guess
  lazy => 1,
  handles => [ qw(log log_debug log_fatal) ],
  default => sub {
    $_[0]->chrome->logger->proxy({ proxy_prefix => '[DZ] ' })
  },
);

sub expand_package {
  return scalar Dist::Zilla::Util->expand_config_package_name($_[1]);
}

sub package_bundle_method {
  my ($self, $pkg) = @_;
  return unless $pkg->isa('Moose::Object')
         and    $pkg->does('Dist::Zilla::Role::PluginBundle');
  return 'bundle_config';
}

before add_value => sub {
  my ($self, $name) = @_;

  return unless $name =~ /\A(?:plugin_name|zilla)\z/;

  my $section_name = $self->current_section->name;
  $self->log_fatal(
    "$section_name arguments attempted to provide reserved argument $name"
  );
};

no Moose;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::MVP::Assembler - Dist::Zilla-specific subclass of Config::MVP::Assembler

=head1 VERSION

version 4.101550

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

