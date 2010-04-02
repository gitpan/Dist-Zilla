package Dist::Zilla::Plugin::ConfirmRelease;
$Dist::Zilla::Plugin::ConfirmRelease::VERSION = '2.100920';
# ABSTRACT: prompt for confirmation before releasing

use ExtUtils::MakeMaker ();

use Moose;
with 'Dist::Zilla::Role::BeforeRelease';

sub before_release {
  my ($self, $tgz) = @_;

  my $prompt =  "\n*** Preparing to upload $tgz to CPAN ***\n\n" .
                "Do you want to continue the release process? (yes/no)";

  my $default = exists $ENV{DZIL_CONFIRMRELEASE_DEFAULT}
              ? $ENV{DZIL_CONFIRMRELEASE_DEFAULT}
              : "no" ;

  my $answer = ExtUtils::MakeMaker::prompt($prompt, $default);

  if ($answer !~ /\A(?:y|ye|yes)\z/i) {
    $self->log_fatal("Aborting release");
  }
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;



=pod

=head1 NAME

Dist::Zilla::Plugin::ConfirmRelease - prompt for confirmation before releasing

=head1 VERSION

version 2.100920

=head1 DESCRIPTION

This plugin prompts the author whether or not to continue before releasing
the distribution to CPAN.  It gives authors a chance to abort before
they upload.

The default is "no", but you can set the environment variable
C<DZIL_CONFIRMRELEASE_DEFAULT> to "yes" if you just want to hit enter to
release.

This plugin uses C<ExtUtils::MakeMaker::prompt()>, so setting
C<PERL_MM_USE_DEFAULT> to a true value will accept the default without
prompting.

=head1 AUTHOR

  Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

