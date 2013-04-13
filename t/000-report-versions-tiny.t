use strict;
use warnings;
use Test::More 0.88;
# This is a relatively nice way to avoid Test::NoWarnings breaking our
# expectations by adding extra tests, without using no_plan.  It also helps
# avoid any other test module that feels introducing random tests, or even
# test plans, is a nice idea.
our $success = 0;
END { $success && done_testing; }

# List our own version used to generate this
my $v = "\nGenerated by Dist::Zilla::Plugin::ReportVersions::Tiny v1.08\n";

eval {                     # no excuses!
    # report our Perl details
    my $want = 'v5.8.5';
    $v .= "perl: $] (wanted $want) on $^O from $^X\n\n";
};
defined($@) and diag("$@");

# Now, our module version dependencies:
sub pmver {
    my ($module, $wanted) = @_;
    $wanted = " (want $wanted)";
    my $pmver;
    eval "require $module;";
    if ($@) {
        if ($@ =~ m/Can't locate .* in \@INC/) {
            $pmver = 'module not found.';
        } else {
            diag("${module}: $@");
            $pmver = 'died during require.';
        }
    } else {
        my $version;
        eval { $version = $module->VERSION; };
        if ($@) {
            diag("${module}: $@");
            $pmver = 'died during VERSION check.';
        } elsif (defined $version) {
            $pmver = "$version";
        } else {
            $pmver = '<undef>';
        }
    }

    # So, we should be good, right?
    return sprintf('%-45s => %-10s%-15s%s', $module, $pmver, $wanted, "\n");
}

eval { $v .= pmver('App::Cmd::Setup','0.309') };
eval { $v .= pmver('App::Cmd::Tester','0.306') };
eval { $v .= pmver('App::Cmd::Tester::CaptureExternal','any version') };
eval { $v .= pmver('Archive::Tar','any version') };
eval { $v .= pmver('CPAN::Meta::Converter','2.101550') };
eval { $v .= pmver('CPAN::Meta::Prereqs','2.120630') };
eval { $v .= pmver('CPAN::Meta::Requirements','2.121') };
eval { $v .= pmver('CPAN::Meta::Validator','2.101550') };
eval { $v .= pmver('CPAN::Uploader','0.103004') };
eval { $v .= pmver('Carp','any version') };
eval { $v .= pmver('Class::Load','0.17') };
eval { $v .= pmver('Config::INI::Reader','any version') };
eval { $v .= pmver('Config::MVP::Assembler','any version') };
eval { $v .= pmver('Config::MVP::Assembler::WithBundles','any version') };
eval { $v .= pmver('Config::MVP::Reader','2.101540') };
eval { $v .= pmver('Config::MVP::Reader::Findable::ByExtension','any version') };
eval { $v .= pmver('Config::MVP::Reader::Finder','any version') };
eval { $v .= pmver('Config::MVP::Reader::INI','2') };
eval { $v .= pmver('Config::MVP::Section','2.200002') };
eval { $v .= pmver('Data::Dumper','any version') };
eval { $v .= pmver('Data::Section','0.004') };
eval { $v .= pmver('DateTime','0.44') };
eval { $v .= pmver('Digest::MD5','any version') };
eval { $v .= pmver('Encode','any version') };
eval { $v .= pmver('ExtUtils::MakeMaker','6.30') };
eval { $v .= pmver('ExtUtils::Manifest','1.54') };
eval { $v .= pmver('File::Copy::Recursive','any version') };
eval { $v .= pmver('File::Find','any version') };
eval { $v .= pmver('File::Find::Rule','any version') };
eval { $v .= pmver('File::HomeDir','any version') };
eval { $v .= pmver('File::Path','any version') };
eval { $v .= pmver('File::ShareDir','any version') };
eval { $v .= pmver('File::ShareDir::Install','0.03') };
eval { $v .= pmver('File::Spec','any version') };
eval { $v .= pmver('File::Temp','any version') };
eval { $v .= pmver('File::pushd','any version') };
eval { $v .= pmver('Hash::Merge::Simple','any version') };
eval { $v .= pmver('JSON','2') };
eval { $v .= pmver('List::AllUtils','any version') };
eval { $v .= pmver('List::MoreUtils','any version') };
eval { $v .= pmver('List::Util','any version') };
eval { $v .= pmver('Log::Dispatchouli','1.102220') };
eval { $v .= pmver('Moose','0.92') };
eval { $v .= pmver('Moose::Autobox','0.10') };
eval { $v .= pmver('Moose::Role','any version') };
eval { $v .= pmver('Moose::Util::TypeConstraints','any version') };
eval { $v .= pmver('MooseX::LazyRequire','any version') };
eval { $v .= pmver('MooseX::Role::Parameterized','any version') };
eval { $v .= pmver('MooseX::SetOnce','any version') };
eval { $v .= pmver('MooseX::Types','any version') };
eval { $v .= pmver('MooseX::Types::Moose','any version') };
eval { $v .= pmver('MooseX::Types::Path::Class','any version') };
eval { $v .= pmver('MooseX::Types::Perl','any version') };
eval { $v .= pmver('PPI','any version') };
eval { $v .= pmver('Params::Util','any version') };
eval { $v .= pmver('Path::Class','any version') };
eval { $v .= pmver('Perl::PrereqScanner','1.005') };
eval { $v .= pmver('Perl::Version','any version') };
eval { $v .= pmver('Pod::Eventual','0.091480') };
eval { $v .= pmver('Scalar::Util','any version') };
eval { $v .= pmver('Software::License','0.101370') };
eval { $v .= pmver('Software::License::None','any version') };
eval { $v .= pmver('Software::LicenseUtils','any version') };
eval { $v .= pmver('String::Formatter','0.100680') };
eval { $v .= pmver('String::RewritePrefix','0.005') };
eval { $v .= pmver('Sub::Exporter','any version') };
eval { $v .= pmver('Sub::Exporter::ForMethods','any version') };
eval { $v .= pmver('Sub::Exporter::Util','any version') };
eval { $v .= pmver('Term::ReadKey','any version') };
eval { $v .= pmver('Term::ReadLine','any version') };
eval { $v .= pmver('Term::ReadLine::Gnu','any version') };
eval { $v .= pmver('Term::UI','any version') };
eval { $v .= pmver('Test::Deep','any version') };
eval { $v .= pmver('Test::Fatal','any version') };
eval { $v .= pmver('Test::File::ShareDir','any version') };
eval { $v .= pmver('Test::More','0.96') };
eval { $v .= pmver('Test::Pod','1.41') };
eval { $v .= pmver('Text::Glob','0.08') };
eval { $v .= pmver('Text::Template','any version') };
eval { $v .= pmver('Try::Tiny','any version') };
eval { $v .= pmver('YAML::Tiny','any version') };
eval { $v .= pmver('autobox','2.53') };
eval { $v .= pmver('autodie','any version') };
eval { $v .= pmver('namespace::autoclean','any version') };
eval { $v .= pmver('parent','any version') };
eval { $v .= pmver('strict','any version') };
eval { $v .= pmver('version','0.9901') };
eval { $v .= pmver('warnings','any version') };


# All done.
$v .= <<'EOT';

Thanks for using my code.  I hope it works for you.
If not, please try and include this output in the bug report.
That will help me reproduce the issue and solve your problem.

EOT

diag($v);
ok(1, "we really didn't test anything, just reporting data");
$success = 1;

# Work around another nasty module on CPAN. :/
no warnings 'once';
$Template::Test::NO_FLUSH = 1;
exit 0;
