requires 'perl' => '5.008005';
requires 'Dist::Zilla';
requires 'Dist::Zilla::Plugin::ConfirmRelease';
requires 'Dist::Zilla::Plugin::DistINI';
requires 'Dist::Zilla::Plugin::ExecDir';
requires 'Dist::Zilla::Plugin::FakeRelease';
requires 'Dist::Zilla::Plugin::GatherDir';
requires 'Dist::Zilla::Plugin::License';
requires 'Dist::Zilla::Plugin::MakeMaker';
requires 'Dist::Zilla::Plugin::Manifest';
requires 'Dist::Zilla::Plugin::ManifestSkip';
requires 'Dist::Zilla::Plugin::MetaConfig';
requires 'Dist::Zilla::Plugin::MetaJSON';
requires 'Dist::Zilla::Plugin::MetaNoIndex';
requires 'Dist::Zilla::Plugin::MetaProvides::Package';
requires 'Dist::Zilla::Plugin::MetaYAML';
requires 'Dist::Zilla::Plugin::PodSyntaxTests' => '5.040'; # moved to author tests
requires 'Dist::Zilla::Plugin::PruneCruft';
requires 'Dist::Zilla::Plugin::ReadmeAnyFromPod';
requires 'Dist::Zilla::Plugin::RunExtraTests';
requires 'Dist::Zilla::Plugin::ShareDir';
requires 'Dist::Zilla::Plugin::TemplateModule';
requires 'Dist::Zilla::Plugin::TestRelease';
requires 'Dist::Zilla::Plugin::Test::Compile';
requires 'Dist::Zilla::Plugin::Test::ReportPrereqs' => '0.014'; # .dd file added
requires 'Dist::Zilla::Plugin::UploadToCPAN';
requires 'Dist::Zilla::Role::MintingProfile::ShareDir';
requires 'Dist::Zilla::Role::PluginBundle::Config::Slicer';
requires 'Dist::Zilla::Role::PluginBundle::Easy';
requires 'Dist::Zilla::Role::PluginBundle::PluginRemover';
requires 'Moose';
requires 'namespace::clean';
requires 'Test::Pod' => '1.41'; # for pod syntax tests
test_requires 'Path::Tiny' => '0.079'; # relative method algorithm
test_requires 'Test::DZil';
test_requires 'Test::More' => '0.88'; # done_testing
