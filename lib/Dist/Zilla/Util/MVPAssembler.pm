package Dist::Zilla::Util::MVPAssembler;
our $VERSION = '1.092070';

use Moose;
extends 'Config::MVP::Assembler';
# ABSTRACT: Dist::Zilla-specific subclass of Config::MVP::Assembler

sub expand_package {
  my $str = Dist::Zilla::Util->expand_config_package_name($_[1]);
  return $str;
}

no Moose;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Util::MVPAssembler - Dist::Zilla-specific subclass of Config::MVP::Assembler

=head1 VERSION

version 1.092070

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


