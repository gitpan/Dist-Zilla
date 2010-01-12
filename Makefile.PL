
use strict;
use warnings;



use ExtUtils::MakeMaker 6.11;



WriteMakefile(
  DISTNAME  => 'Dist-Zilla',
  NAME      => 'Dist::Zilla',
  AUTHOR    => "Ricardo\ SIGNES\ \<rjbs\@cpan\.org\>",
  ABSTRACT  => "distribution\ builder\;\ installer\ not\ included\!",
  VERSION   => '1.100120',
  EXE_FILES => [ "bin\/dzil" ],
  (eval { ExtUtils::MakeMaker->VERSION(6.31) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "DateTime" => '0.44',
    "PPI" => '0',
    "Config::INI::MVP::Reader" => '0.024',
    "App::Cmd" => '0.299',
    "Pod::Eventual" => '0.091480',
    "String::RewritePrefix" => '0.002',
    "Data::Section" => '0.004',
    "File::chdir" => '0',
    "Config::MVP" => '0.092990',
    "Perl::Version" => '0',
    "autobox" => '2.53',
    "Software::License" => '0',
    "Archive::Tar" => '0',
    "List::MoreUtils" => '0',
    "Moose" => '0.92',
    "ExtUtils::Manifest" => '1.54',
    "String::Flogger" => '1',
    "File::Find::Rule" => '0',
    "Mixin::ExtraFields::Param" => '0',
    "namespace::autoclean" => '0',
    "YAML::Tiny" => '0',
    "File::HomeDir" => '0',
    "ExtUtils::MakeMaker" => '0',
    "CPAN::Uploader" => '0',
    "Moose::Autobox" => '0.09',
    "Test::More" => '0',
    "MooseX::Types::Path::Class" => '0',
    "Hash::Merge::Simple" => '0',
    "File::Temp" => '0',
    "Path::Class" => '0',
    "String::Formatter" => '0',
    "File::ShareDir::Install" => '0.03',
    "Text::Template" => '0',
  },
  test => {TESTS => 't/*.t'}
);



