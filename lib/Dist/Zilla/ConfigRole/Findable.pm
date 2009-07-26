package Dist::Zilla::ConfigRole::Findable;
our $VERSION = '1.092070';

use Moose::Role;
# ABSTRACT: a config class that Dist::Zilla::Config::Finder can find

requires 'can_be_found';

no Moose::Role;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::ConfigRole::Findable - a config class that Dist::Zilla::Config::Finder can find

=head1 VERSION

version 1.092070

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as perl itself.

=cut 


