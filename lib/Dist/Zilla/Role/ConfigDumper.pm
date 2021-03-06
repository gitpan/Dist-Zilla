package Dist::Zilla::Role::ConfigDumper;
# ABSTRACT: something that can dump its (public, simplified) configuration
$Dist::Zilla::Role::ConfigDumper::VERSION = '5.030';
use Moose::Role;

use namespace::autoclean;

sub dump_config { return {}; }

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Role::ConfigDumper - something that can dump its (public, simplified) configuration

=head1 VERSION

version 5.030

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
