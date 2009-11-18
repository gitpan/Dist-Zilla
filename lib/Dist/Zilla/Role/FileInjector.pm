package Dist::Zilla::Role::FileInjector;
our $VERSION = '1.093220';


use Moose::Autobox;
# ABSTRACT: something that can add files to the distribution
use Moose::Role;


sub add_file {
  my ($self, $file) = @_;
  my ($pkg, undef, $line) = caller;

  $file->meta->get_attribute('added_by')->set_value($file, "$pkg line $line");
  # $self->log($file->name . " added by $pkg");
  $self->zilla->files->push($file);
}

no Moose::Role;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::Role::FileInjector - something that can add files to the distribution

=head1 VERSION

version 1.093220

=head1 DESCRIPTION

This role should be implemented by any plugin that plans to add files into the
distribution.  It provides one method (C<L</add_file>>, documented below),
which adds a file to the distribution, noting the place of addition.

=head1 METHODS

=head2 add_file

  $plugin->add_file($dzil_file);

This adds a file to the distribution, setting the file's C<added_by> attribute
as it does so.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

