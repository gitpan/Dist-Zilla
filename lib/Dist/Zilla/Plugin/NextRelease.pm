package Dist::Zilla::Plugin::NextRelease;
{
  $Dist::Zilla::Plugin::NextRelease::VERSION = '5.006';
}
# ABSTRACT: update the next release number in your changelog

use namespace::autoclean;

use Moose;
with (
  'Dist::Zilla::Role::FileMunger',
  'Dist::Zilla::Role::TextTemplate',
  'Dist::Zilla::Role::AfterRelease',
);

use DateTime 0.44; # CLDR fixes
use Path::Tiny;
use Moose::Util::TypeConstraints;
use String::Formatter 0.100680 stringf => {
  -as => '_format_version',

  input_processor => 'require_single_input',
  string_replacer => 'method_replace',
  codes => {
    v => sub { $_[0]->zilla->version },
    d => sub {
      DateTime->from_epoch(epoch => $^T, time_zone => $_[0]->time_zone)
              ->format_cldr($_[1]),
    },
    t => sub { "\t" },
    n => sub { "\n" },
    E => sub { $_[0]->_user_info('email') },
    U => sub { $_[0]->_user_info('name')  },
    T => sub { $_[0]->zilla->is_trial
                   ? (defined $_[1] ? $_[1] : '-TRIAL') : '' },
    V => sub { $_[0]->zilla->version
                . ($_[0]->zilla->is_trial
                   ? (defined $_[1] ? $_[1] : '-TRIAL') : '') },
  },
};

has time_zone => (
  is => 'ro',
  isa => 'Str', # should be more validated later -- apocal
  default => 'local',
);

has format => (
  is  => 'ro',
  isa => 'Str', # should be more validated Later -- rjbs, 2008-06-05
  default => '%-9v %{yyyy-MM-dd HH:mm:ss VVVV}d%{ (TRIAL RELEASE)}T',
);

has filename => (
  is  => 'ro',
  isa => 'Str',
  default => 'Changes',
);

has update_filename => (
  is  => 'ro',
  isa => 'Str',
  lazy    => 1,
  default => sub { $_[0]->filename },
);

has user_stash => (
  is      => 'ro',
  isa     => 'Str',
  default => '%User'
);

has _user_stash_obj => (
  is       => 'ro',
  isa      => maybe_type( class_type('Dist::Zilla::Stash::User') ),
  lazy     => 1,
  init_arg => undef,
  default  => sub { $_[0]->zilla->stash_named( $_[0]->user_stash ) },
);

sub _user_info {
  my ($self, $field) = @_;

  my $stash = $self->_user_stash_obj;

  $self->log_fatal([
    "You must enter your %s in the [%s] section in ~/.dzil/config.ini",
    $field, $self->user_stash
  ]) unless $stash and defined(my $value = $stash->$field);

  return $value;
}

sub section_header {
  my ($self) = @_;

  return _format_version($self->format, $self);
}

sub munge_files {
  my ($self) = @_;

  my ($file) = grep { $_->name eq $self->filename } @{ $self->zilla->files };
  return unless $file;

  my $content = $self->fill_in_string(
    $file->content,
    {
      dist    => \($self->zilla),
      version => \($self->zilla->version),
      NEXT    => \($self->section_header),
    },
  );

  $self->log_debug([ 'updating contents of %s in memory', $file->name ]);
  $file->content($content);
}

# new release is part of distribution history, let's record that.
sub after_release {
  my ($self) = @_;
  my $filename = $self->filename;
  my ($gathered_file) = grep { $_->name eq $filename } @{ $self->zilla->files };
  my $iolayer = sprintf(":raw:encoding(%s)", $gathered_file->encoding);

  # read original changelog
  my $content = path($filename)->slurp({ binmode => $iolayer});

  # add the version and date to file content
  my $delim  = $self->delim;
  my $header = $self->section_header;
  $content =~ s{ (\Q$delim->[0]\E \s*) \$NEXT (\s* \Q$delim->[1]\E) }
               {$1\$NEXT$2\n\n$header}xs;

  my $update_fn = $self->update_filename;
  $self->log_debug([ 'updating contents of %s on disk', $update_fn ]);

  # and finally rewrite the changelog on disk
  path($update_fn)->spew({binmode => $iolayer}, $content);
}

__PACKAGE__->meta->make_immutable;
1;

__END__

=pod

=head1 NAME

Dist::Zilla::Plugin::NextRelease - update the next release number in your changelog

=head1 VERSION

version 5.006

=head1 SYNOPSIS

In your F<dist.ini>:

  [NextRelease]

In your F<Changes> file:

  {{$NEXT}}

=head1 DESCRIPTION

Tired of having to update your F<Changes> file by hand with the new
version and release date / time each time you release your distribution?
Well, this plugin is for you.

Add this plugin to your F<dist.ini>, and the following to your
F<Changes> file:

  {{$NEXT}}

The C<NextRelease> plugin will then do 2 things:

=over 4

=item * At build time, this special marker will be replaced with the
version and the build date, to form a standard changelog header. This
will be done to the in-memory file - the original F<Changes> file won't
be updated.

=item * After release (when running C<dzil release>), since the version
and build date are now part of your dist's history, the real F<Changes>
file (not the in-memory one) will be updated with this piece of
information.

=back

The module accepts the following options in its F<dist.ini> section:

=over 4

=item filename

the name of your changelog file;  defaults to F<Changes>

=item update_filename

the file to which to write an updated changelog to; defaults to the C<filename>

=item format

sprintf-like string used to compute the next value of C<{{$NEXT}}>;
defaults to C<%-9v %{yyyy-MM-dd HH:mm:ss VVVV}d>

=item time_zone

the timezone to use when generating the date;  defaults to I<local>

=item user_stash

the name of the stash where the user's name and email address can be found;
defaults to C<%User>

=back

The module allows the following sprintf-like format codes in the C<format>:

=over 4

=item C<%v>

The distribution version

=item C<%{-TRIAL}T>

Expands to -TRIAL (or any other supplied string) if this
is a trial release, or the empty string if not.  A bare C<%T> means
C<%{-TRIAL}T>.

=item C<%{-TRIAL}V>

Equivalent to C<%v%{-TRIAL}T>, to allow for the application of modifiers such
as space padding to the entire version string produced.

=item C<%{CLDR format}d>

The date of the release.  You can use any CLDR format supported by
L<DateTime>.  You must specify the format; there is no default.

=item C<%U>

The name of the user making this release (from C<user_stash>).

=item C<%E>

The email address of the user making this release (from C<user_stash>).

=item C<%n>

A newline

=item C<%t>

A tab

=back

=head1 SEE ALSO

Core Dist::Zilla plugins:
L<AutoVersion|Dist::Zilla::Plugin::AutoVersion>,
L<PkgVersion|Dist::Zilla::Plugin::PkgVersion>,
L<PodVersion|Dist::Zilla::Plugin::PodVersion>.

Dist::Zilla roles:
L<AfterRelease|Dist::Zilla::Plugin::AfterRelease>,
L<FileMunger|Dist::Zilla::Role::FileMunger>,
L<TextTemplate|Dist::Zilla::Role::TextTemplate>.

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
