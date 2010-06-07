
use strict;
use warnings;

 BEGIN { require v5.8.5; } 

use ExtUtils::MakeMaker 6.31;

use File::ShareDir::Install;
install_share "share";


my %WriteMakefileArgs = (
  'ABSTRACT' => 'distribution builder; installer not included!',
  'AUTHOR' => 'Ricardo SIGNES <rjbs@cpan.org>',
  'BUILD_REQUIRES' => {
    'Test::Deep' => '0',
    'Test::More' => '0.90'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31',
    'File::ShareDir::Install' => '0.03'
  },
  'DISTNAME' => 'Dist-Zilla',
  'EXE_FILES' => [
    'bin/dzil'
  ],
  'LICENSE' => 'perl',
  'NAME' => 'Dist::Zilla',
  'PREREQ_PM' => {
    'App::Cmd::Setup' => '0.307',
    'App::Cmd::Tester' => '0.306',
    'Archive::Tar' => '0',
    'CPAN::Meta::Converter' => '2.101550',
    'CPAN::Meta::Prereqs' => '2.101390',
    'CPAN::Meta::Validator' => '2.101550',
    'CPAN::Uploader' => '0.101550',
    'Carp' => '0',
    'Config' => '0',
    'Config::MVP' => '2',
    'Config::MVP::Assembler' => '0',
    'Config::MVP::Assembler::WithBundles' => '0',
    'Config::MVP::Reader' => '2.101540',
    'Config::MVP::Reader::Findable::ByExtension' => '0',
    'Config::MVP::Reader::Finder' => '0',
    'Config::MVP::Reader::INI' => '2',
    'Config::MVP::Section' => '0',
    'Data::Dumper' => '0',
    'Data::Section' => '0.004',
    'DateTime' => '0.44',
    'ExtUtils::MakeMaker' => '0',
    'ExtUtils::Manifest' => '1.54',
    'File::Copy::Recursive' => '0',
    'File::Find::Rule' => '0',
    'File::HomeDir' => '0',
    'File::Path' => '0',
    'File::ShareDir' => '0',
    'File::ShareDir::Install' => '0.03',
    'File::Spec' => '0',
    'File::Temp' => '0',
    'File::pushd' => '0',
    'Hash::Merge::Simple' => '0',
    'JSON' => '2',
    'List::MoreUtils' => '0',
    'List::Util' => '0',
    'Log::Dispatchouli' => '1.100712',
    'Moose' => '0.92',
    'Moose::Autobox' => '0.09',
    'Moose::Role' => '0',
    'Moose::Util::TypeConstraints' => '0',
    'MooseX::LazyRequire' => '0',
    'MooseX::Role::Parameterized' => '0',
    'MooseX::SetOnce' => '0',
    'MooseX::Types' => '0',
    'MooseX::Types::Moose' => '0',
    'MooseX::Types::Path::Class' => '0',
    'MooseX::Types::Perl' => '0',
    'PPI' => '0',
    'Params::Util' => '0',
    'Path::Class' => '0',
    'Perl::PrereqScanner' => '0.100830',
    'Perl::Version' => '0',
    'Pod::Eventual' => '0.091480',
    'Scalar::Util' => '0',
    'Software::License' => '0.101370',
    'Software::LicenseUtils' => '0',
    'String::Formatter' => '0.100680',
    'String::RewritePrefix' => '0.005',
    'Sub::Exporter' => '0',
    'Sub::Exporter::Util' => '0',
    'Text::Template' => '0',
    'Try::Tiny' => '0',
    'Version::Requirements' => '0.100630',
    'YAML::Tiny' => '0',
    'autobox' => '2.53',
    'autodie' => '0',
    'namespace::autoclean' => '0',
    'version' => '0'
  },
  'VERSION' => '4.101582',
  'test' => {
    'TESTS' => 't/*.t t/plugins/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

package
MY;
use File::ShareDir::Install qw(postamble);


