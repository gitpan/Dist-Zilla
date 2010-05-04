
use strict;
use warnings;

 BEGIN { require v5.8.5; } 

use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t t/plugins/*.t'
                                 },
                       'NAME' => 'Dist::Zilla',
                       'DISTNAME' => 'Dist-Zilla',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.31'
                                               },
                       'AUTHOR' => 'Ricardo SIGNES <rjbs@cpan.org>',
                       'BUILD_REQUIRES' => {
                                             'Try::Tiny' => '0',
                                             'Test::More' => '0.90'
                                           },
                       'ABSTRACT' => 'distribution builder; installer not included!',
                       'EXE_FILES' => [
                                        'bin/dzil'
                                      ],
                       'VERSION' => '2.101240',
                       'PREREQ_PM' => {
                                        'DateTime' => '0.44',
                                        'PPI' => '0',
                                        'Perl::PrereqScanner' => '0.100830',
                                        'Pod::Eventual' => '0.091480',
                                        'Sub::Exporter' => '0',
                                        'List::Util' => '0',
                                        'Config::MVP' => '0.100780',
                                        'App::Cmd::Setup' => '0.307',
                                        'autodie' => '0',
                                        'Config::MVP::Assembler::WithBundles' => '0',
                                        'autobox' => '2.53',
                                        'Software::License' => '0',
                                        'File::Path' => '0',
                                        'Archive::Tar' => '0',
                                        'List::MoreUtils' => '0',
                                        'ExtUtils::Manifest' => '1.54',
                                        'Moose::Role' => '0',
                                        'File::HomeDir' => '0',
                                        'File::pushd' => '0',
                                        'Data::Dumper' => '0',
                                        'ExtUtils::MakeMaker' => '0',
                                        'Config::MVP::Reader' => '0',
                                        'Moose::Autobox' => '0.09',
                                        'MooseX::Types::Path::Class' => '0',
                                        'Hash::Merge::Simple' => '0',
                                        'MooseX::Types' => '0',
                                        'File::Temp' => '0',
                                        'Config::MVP::Reader::Finder' => '0',
                                        'File::Copy::Recursive' => '0',
                                        'Path::Class' => '0',
                                        'Text::Template' => '0',
                                        'App::Cmd::Tester' => '0.306',
                                        'Config::MVP::Assembler' => '0',
                                        'MooseX::Types::Moose' => '0',
                                        'Scalar::Util' => '0',
                                        'Config::INI::MVP::Reader' => '0.024',
                                        'File::Spec' => '0',
                                        'String::RewritePrefix' => '0.005',
                                        'Data::Section' => '0.004',
                                        'Moose::Util::TypeConstraints' => '0',
                                        'Params::Util' => '0',
                                        'Log::Dispatchouli' => '1.100712',
                                        'Perl::Version' => '0',
                                        'Moose' => '0.92',
                                        'Software::LicenseUtils' => '0',
                                        'File::Find::Rule' => '0',
                                        'namespace::autoclean' => '0',
                                        'YAML::Tiny' => '0',
                                        'version' => '0.82',
                                        'CPAN::Uploader' => '0.100660',
                                        'Carp' => '0',
                                        'Sub::Exporter::Util' => '0',
                                        'Version::Requirements' => '0.100630',
                                        'Config::MVP::Reader::Findable' => '0',
                                        'MooseX::Role::Parameterized' => '0',
                                        'JSON' => '2',
                                        'String::Formatter' => '0.100680',
                                        'File::ShareDir::Install' => '0.03'
                                      },
                       'LICENSE' => 'perl'
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



