package Dist::Zilla::ConfigRole::Findable;
our $VERSION = '1.092850';


use Moose::Role;
# ABSTRACT: a config class that Dist::Zilla::Config::Finder can find

requires 'can_be_found';
requires 'default_extension';

sub can_be_found {
  my ($self, $arg) = @_;

  my $config_file = $self->filename_from_args($arg);
  return -r "$config_file" and -f _;
}

sub filename_from_args {
  my ($self, $arg) = @_;

  # XXX: maybe we should detect conflicting cases -- rjbs, 2009-08-18
  my $filename;
  if ($arg->{filename}) {
    $filename = $arg->{filename}
  } else {
    my $basename = $arg->{basename};
    confess "no filename or basename supplied"
      unless defined $arg->{basename} and length $arg->{basename};

    my $extension = $self->default_extension;
    $filename = $basename;
    $filename .= ".$extension" if defined $extension;
  }

  return $arg->{root}->file($filename);
}

no Moose::Role;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::ConfigRole::Findable - a config class that Dist::Zilla::Config::Finder can find

=head1 VERSION

version 1.092850

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2009 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut 


