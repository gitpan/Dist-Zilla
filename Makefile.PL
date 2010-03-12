
use strict;
use warnings;

 BEGIN { require v5.8.5; } 

use ExtUtils::MakeMaker 6.11;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'Dist::Zilla',
                       'DISTNAME' => 'Dist-Zilla',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.11'
                                               },
                       'AUTHOR' => 'Ricardo SIGNES <rjbs@cpan.org>',
                       'BUILD_REQUIRES' => {},
                       'ABSTRACT' => 'distribution builder; installer not included!',
                       'EXE_FILES' => [
                                        'bin/dzil'
                                      ],
                       'VERSION' => '1.100710',
                       'PREREQ_PM' => {
                                        'Dist::Zilla::Logger::Global' => '0',
                                        'Sub::Exporter' => '0',
                                        'MooseX::Singleton' => '0.22',
                                        'Config' => '0',
                                        'CPAN::Version' => '0',
                                        'File::Path' => '0',
                                        'List::MoreUtils' => '0',
                                        'Mixin::ExtraFields::Param' => '0',
                                        'File::HomeDir' => '0',
                                        'ExtUtils::MakeMaker' => '0',
                                        'Config::MVP::Reader' => '0',
                                        'MooseX::Types::Path::Class' => '0',
                                        'MooseX::Types' => '0',
                                        'Config::MVP::Reader::Finder' => '0',
                                        'Path::Class' => '0',
                                        'MooseX::Types::Moose' => '0',
                                        'Data::Section' => '0.004',
                                        'Moose::Util::TypeConstraints' => '0',
                                        'Log::Dispatchouli' => '1.100710',
                                        'Params::Util' => '0',
                                        'Perl::Version' => '0',
                                        'Moose' => '0.92',
                                        'File::Find::Rule' => '0',
                                        'namespace::autoclean' => '0',
                                        'YAML::Tiny' => '0',
                                        'version' => '0.79',
                                        'CPAN::Uploader' => '0.100660',
                                        'Carp' => '0',
                                        'File::ShareDir::Install' => '0.03',
                                        'DateTime' => '0.44',
                                        'PPI' => '0',
                                        'Pod::Eventual' => '0.091480',
                                        'App::Cmd' => '0.299',
                                        'App::Cmd::Setup' => '0.307',
                                        'Config::MVP' => '0.092990',
                                        'Mixin::ExtraFields' => '0',
                                        'Config::MVP::Assembler::WithBundles' => '0',
                                        'autobox' => '2.53',
                                        'Software::License' => '0',
                                        'Archive::Tar' => '0',
                                        'String::Flogger' => '1',
                                        'ExtUtils::Manifest' => '1.54',
                                        'Moose::Role' => '0',
                                        'Try::Tiny' => '0',
                                        'Data::Dumper' => '0',
                                        'Moose::Autobox' => '0.09',
                                        'Test::More' => '0',
                                        'Hash::Merge::Simple' => '0',
                                        'File::Temp' => '0',
                                        'File::Copy::Recursive' => '0',
                                        'Text::Template' => '0',
                                        'App::Cmd::Tester' => '0.306',
                                        'Scalar::Util' => '0',
                                        'Config::MVP::Assembler' => '0',
                                        'Config::INI::MVP::Reader' => '0.024',
                                        'File::Spec' => '0',
                                        'String::RewritePrefix' => '0.002',
                                        'File::chdir' => '0',
                                        'Software::LicenseUtils' => '0',
                                        'Sub::Exporter::Util' => '0',
                                        'Version::Requirements' => '0',
                                        'Config::INI::Reader' => '0',
                                        'Config::MVP::Reader::Findable' => '0',
                                        'CPAN' => '0',
                                        'String::Formatter' => '0.100680',
                                        'JSON' => '0'
                                      },
                       'LICENSE' => 'perl'
                     );


delete $WriteMakefileArgs{LICENSE}
  unless eval { ExtUtils::MakeMaker->VERSION(6.31) };

WriteMakefile(%WriteMakefileArgs);



