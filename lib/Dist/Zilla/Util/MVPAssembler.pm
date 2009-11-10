package Dist::Zilla::Util::MVPAssembler;
our $VERSION = '1.093140';


use Moose;
extends 'Config::MVP::Assembler';
with 'Config::MVP::Assembler::WithBundles';
# ABSTRACT: Dist::Zilla-specific subclass of Config::MVP::Assembler

sub expand_package {
  my $str = Dist::Zilla::Util->expand_config_package_name($_[1]);
  return $str;
}

sub package_bundle_method {
  my ($self, $pkg) = @_;
  return unless $pkg->isa('Moose::Object')
         and    $pkg->does('Dist::Zilla::Role::PluginBundle');
  return 'bundle_config';
}

no Moose;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Util::MVPAssembler - Dist::Zilla-specific subclass of Config::MVP::Assembler

=head1 VERSION

version 1.093140

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

