use strict;
use warnings;
package Dist::Zilla::Util;
BEGIN {
  $Dist::Zilla::Util::VERSION = '3.101400';
}
# ABSTRACT: random snippets of code that Dist::Zilla wants

use String::RewritePrefix 0.002; # better string context behavior

{
  package
    Dist::Zilla::Util::PEA;
BEGIN {
  $Dist::Zilla::Util::PEA::VERSION = '3.101400';
}
  use Pod::Eventual 0.091480; # better nonpod/blank events
  use base 'Pod::Eventual';
  sub _new  { bless {} => shift; }
  sub handle_nonpod {
    my ($self, $event) = @_;
    return if $self->{abstract};
    return $self->{abstract} = $1
      if $event->{content}=~ /^\s*#+\s*ABSTRACT:\s*(.+)$/m;
    return;
  }
  sub handle_event {
    my ($self, $event) = @_;
    return if $self->{abstract};
    if (
      ! $self->{in_name}
      and $event->{type} eq 'command'
      and $event->{command} eq 'head1'
      and $event->{content} =~ /^NAME\b/
    ) {
      $self->{in_name} = 1;
      return;
    }

    return unless $self->{in_name};
    
    if (
      $event->{type} eq 'text'
      and $event->{content} =~ /^\S+\s+-+\s+(.+)$/
    ) {
      $self->{abstract} = $1;
    }
  }
}


sub abstract_from_file {
  my ($self, $filename) = @_;
  my $e = Dist::Zilla::Util::PEA->_new;
  $e->read_file($filename);
  return $e->{abstract};
}


sub expand_config_package_name {
  my ($self, $package) = @_;

  my $str = String::RewritePrefix->rewrite(
    {
      '=' => '',
      '@' => 'Dist::Zilla::PluginBundle::',
      '!' => 'Dist::Zilla::App::Command::',
      ''  => 'Dist::Zilla::Plugin::',
    },
    $package,
  );

  return $str;
}

1;

__END__
=pod

=head1 NAME

Dist::Zilla::Util - random snippets of code that Dist::Zilla wants

=head1 VERSION

version 3.101400

=head1 METHODS

=head2 abstract_from_file

This method, I<which is likely to change or go away>, tries to guess the
abstract of a given file, assuming that it's Perl code.  It looks for a POD
C<=head1> section called "NAME" or a comment beginning with C<ABSTRACT:>.

=head2 expand_config_package_name 

  my $pkg_name = Util->expand_config_package_name($string);

This method, I<which is likely to change or go away>, rewrites the given string
into a package name.  Consult L<Dist::Zilla::Config|Dist::Zilla::Config> for
more information.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

