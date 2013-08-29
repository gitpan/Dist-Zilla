requires "App::Cmd::Setup" => "0.309";
requires "App::Cmd::Tester" => "0.306";
requires "App::Cmd::Tester::CaptureExternal" => "0";
requires "Archive::Tar" => "0";
requires "CPAN::Meta::Converter" => "2.101550";
requires "CPAN::Meta::Prereqs" => "2.120630";
requires "CPAN::Meta::Requirements" => "2.121";
requires "CPAN::Meta::Validator" => "2.101550";
requires "CPAN::Uploader" => "0.103004";
requires "Carp" => "0";
requires "Class::Load" => "0.17";
requires "Config::INI::Reader" => "0";
requires "Config::MVP::Assembler" => "0";
requires "Config::MVP::Assembler::WithBundles" => "0";
requires "Config::MVP::Reader" => "2.101540";
requires "Config::MVP::Reader::Findable::ByExtension" => "0";
requires "Config::MVP::Reader::Finder" => "0";
requires "Config::MVP::Reader::INI" => "2";
requires "Config::MVP::Section" => "2.200002";
requires "Data::Dumper" => "0";
requires "Data::Section" => "0.004";
requires "DateTime" => "0.44";
requires "Digest::MD5" => "0";
requires "Encode" => "0";
requires "ExtUtils::Manifest" => "1.54";
requires "File::Copy::Recursive" => "0";
requires "File::Find::Rule" => "0";
requires "File::HomeDir" => "0";
requires "File::Path" => "0";
requires "File::ShareDir" => "0";
requires "File::ShareDir::Install" => "0.03";
requires "File::Spec" => "0";
requires "File::Temp" => "0";
requires "File::pushd" => "0";
requires "Hash::Merge::Simple" => "0";
requires "JSON" => "2";
requires "List::AllUtils" => "0";
requires "List::MoreUtils" => "0";
requires "List::Util" => "0";
requires "Log::Dispatchouli" => "1.102220";
requires "Moose" => "0.92";
requires "Moose::Autobox" => "0.10";
requires "Moose::Role" => "0";
requires "Moose::Util::TypeConstraints" => "0";
requires "MooseX::LazyRequire" => "0";
requires "MooseX::Role::Parameterized" => "0";
requires "MooseX::SetOnce" => "0";
requires "MooseX::Types" => "0";
requires "MooseX::Types::Moose" => "0";
requires "MooseX::Types::Path::Class" => "0";
requires "MooseX::Types::Perl" => "0";
requires "PPI" => "0";
requires "Params::Util" => "0";
requires "Path::Class" => "0.22";
requires "Perl::PrereqScanner" => "1.016";
requires "Perl::Version" => "0";
requires "Pod::Eventual" => "0.091480";
requires "Scalar::Util" => "0";
requires "Software::License" => "0.101370";
requires "Software::LicenseUtils" => "0";
requires "String::Formatter" => "0.100680";
requires "String::RewritePrefix" => "0.005";
requires "Sub::Exporter" => "0";
requires "Sub::Exporter::ForMethods" => "0";
requires "Sub::Exporter::Util" => "0";
requires "Term::ReadKey" => "0";
requires "Term::ReadLine" => "0";
requires "Term::UI" => "0";
requires "Test::Deep" => "0";
requires "Text::Glob" => "0.08";
requires "Text::Template" => "0";
requires "Try::Tiny" => "0";
requires "YAML::Tiny" => "0";
requires "autobox" => "2.53";
requires "autodie" => "0";
requires "namespace::autoclean" => "0";
requires "parent" => "0";
requires "perl" => "v5.8.5";
requires "strict" => "0";
requires "version" => "0";
requires "warnings" => "0";
recommends "Term::ReadLine::Gnu" => "0";

on 'test' => sub {
  requires "Capture::Tiny" => "0";
  requires "Software::License::None" => "0";
  requires "Test::Fatal" => "0";
  requires "Test::File::ShareDir" => "0";
  requires "Test::More" => "0.96";
  requires "Test::Script" => "1.05";
  requires "blib" => "0";
  requires "lib" => "0";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "6.30";
  requires "File::ShareDir::Install" => "0.03";
};

on 'develop' => sub {
  requires "Test::Pod" => "1.41";
  requires "version" => "0.9901";
};
