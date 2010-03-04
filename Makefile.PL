
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
                       'VERSION' => '1.100630',
                       'PREREQ_PM' => {
                                        'PPI' => 0,
                                        'DateTime' => '0.44',
                                        'Pod::Eventual' => '0.091480',
                                        'App::Cmd' => '0.299',
                                        'MooseX::Singleton' => '0.22',
                                        'Config::MVP' => '0.092990',
                                        'autobox' => '2.53',
                                        'Software::License' => 0,
                                        'Archive::Tar' => 0,
                                        'List::MoreUtils' => 0,
                                        'ExtUtils::Manifest' => '1.54',
                                        'String::Flogger' => '1',
                                        'Mixin::ExtraFields::Param' => 0,
                                        'File::HomeDir' => 0,
                                        'ExtUtils::MakeMaker' => 0,
                                        'Moose::Autobox' => '0.09',
                                        'Test::More' => 0,
                                        'MooseX::Types::Path::Class' => 0,
                                        'Hash::Merge::Simple' => 0,
                                        'File::Temp' => 0,
                                        'Path::Class' => 0,
                                        'Text::Template' => 0,
                                        'Config::INI::MVP::Reader' => '0.024',
                                        'String::RewritePrefix' => '0.002',
                                        'Data::Section' => '0.004',
                                        'File::chdir' => 0,
                                        'Log::Dispatchouli' => '1.004',
                                        'Perl::Version' => 0,
                                        'Moose' => '0.92',
                                        'File::Find::Rule' => 0,
                                        'namespace::autoclean' => 0,
                                        'YAML::Tiny' => 0,
                                        'CPAN::Uploader' => 0,
                                        'String::Formatter' => 0,
                                        'File::ShareDir::Install' => '0.03'
                                      },
                       'LICENSE' => 'perl'
                     );


delete $WriteMakefileArgs{LICENSE}
  unless eval { ExtUtils::MakeMaker->VERSION(6.31) };

WriteMakefile(%WriteMakefileArgs);



