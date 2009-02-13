
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Dist-Zilla',
  NAME      => 'Dist::Zilla',
  AUTHOR    => 'Ricardo\ SIGNES\ \<rjbs\@cpan\.org\>',
  ABSTRACT  => 'distribution builder; installer not included!',
  VERSION   => '1.004',
  EXE_FILES => [ qw(bin/dzil) ],
  (eval { ExtUtils::MakeMaker->VERSION(6.21) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "DateTime" => '0.42',
    "Config::INI::MVP::Reader" => '0.018',
    "Pod::Eventual" => '0',
    "App::Cmd" => '0.200',
    "String::RewritePrefix" => '0.002',
    "Data::Section" => '0.004',
    "File::chdir" => '0',
    "String::Format" => '0',
    "Perl::Version" => '0',
    "autobox" => '2.40',
    "Software::License" => '0',
    "Archive::Tar" => '0',
    "MooseX::ClassAttribute" => '0',
    "List::MoreUtils" => '0',
    "ExtUtils::Manifest" => '1.54',
    "String::Flogger" => '1',
    "Moose" => '0.45',
    "Mixin::ExtraFields::Param" => '0',
    "File::Find::Rule" => '0',
    "File::HomeDir" => '0',
    "ExtUtils::MakeMaker" => '0',
    "CPAN::Uploader" => '0',
    "YAML::Syck" => '0',
    "Moose::Autobox" => '0',
    "Test::More" => '0',
    "MooseX::Types::Path::Class" => '0',
    "File::Temp" => '0',
    "Path::Class" => '0',
    "Text::Template" => '0',
  },
);
