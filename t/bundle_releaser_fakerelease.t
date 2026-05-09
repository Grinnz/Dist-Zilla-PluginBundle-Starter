use strict;
use warnings;
use Path::Tiny;
use Test::More;
use Test::DZil;

local $ENV{FAKE_RELEASE} = 0;

# releaser = FakeRelease

my $tzil = Builder->from_config(
  { dist_root => 'does-not-exist' },
  {
    add_files => {
      path('source', 'dist.ini') => simple_ini({},
        ['@Starter' => { revision => 7, regenerate => 'LICENSE', releaser => 'FakeRelease',
          -remove => ['Test::ReportPrereqs', 'ConfirmRelease'] }],
      ),
      path('source', 'lib', 'DZT', 'Sample.pm') => "package DZT::Sample;\nour \$VERSION = '0.001';\n1",
    },
  },
);

# ensure no accidental uploads
die 'UploadToCPAN plugin found, aborting'
  if grep { $_->meta->name eq 'Dist::Zilla::Plugin::UploadToCPAN' } @{$tzil->plugins_with(-Releaser)};

my $root_license = path($tzil->root)->child('LICENSE');

ok !$root_license->exists, 'LICENSE is not present in root';

$tzil->build;
$tzil->release;

my $build_license = path($tzil->tempdir)->child('build', 'LICENSE');
ok $build_license->exists, 'LICENSE is present in release';
ok $root_license->exists, 'LICENSE was regenerated after release';
is $root_license->slurp, $build_license->slurp, 'regenerated LICENSE matches built file';

# releaser = (ThisPluginDoesNotExist)

ok !eval { $tzil = Builder->from_config(
  { dist_root => 'does-not-exist' },
  {
    add_files => {
      path('source', 'dist.ini') => simple_ini({},
        ['@Starter' => { revision => 7, regenerate => 'LICENSE', releaser => '(ThisPluginDoesNotExist)',
          -remove => ['Test::ReportPrereqs', 'ConfirmRelease'] }],
      ),
      path('source', 'lib', 'DZT', 'Sample.pm') => "package DZT::Sample;\nour \$VERSION = '0.001';\n1",
    },
  },
) }, 'Bogus releaser plugin not found';

# FAKE_RELEASE = 1 overriding default releaser

local $ENV{FAKE_RELEASE} = 1;

$tzil = Builder->from_config(
  { dist_root => 'does-not-exist' },
  {
    add_files => {
      path('source', 'dist.ini') => simple_ini({},
        ['@Starter' => { revision => 7, regenerate => 'LICENSE',
          -remove => ['Test::ReportPrereqs', 'ConfirmRelease'] }],
      ),
      path('source', 'lib', 'DZT', 'Sample.pm') => "package DZT::Sample;\nour \$VERSION = '0.001';\n1",
    },
  },
);

# ensure no accidental uploads
die 'UploadToCPAN plugin found, aborting'
  if grep { $_->meta->name eq 'Dist::Zilla::Plugin::UploadToCPAN' } @{$tzil->plugins_with(-Releaser)};

$root_license = path($tzil->root)->child('LICENSE');

ok !$root_license->exists, 'LICENSE is not present in root';

$tzil->build;
$tzil->release;

$build_license = path($tzil->tempdir)->child('build', 'LICENSE');
ok $build_license->exists, 'LICENSE is present in release';
ok $root_license->exists, 'LICENSE was regenerated after release';
is $root_license->slurp, $build_license->slurp, 'regenerated LICENSE matches built file';

# FAKE_RELEASE = 1 overriding releaser = (ThisPluginDoesNotExist)

local $ENV{FAKE_RELEASE} = 1;

$tzil = Builder->from_config(
  { dist_root => 'does-not-exist' },
  {
    add_files => {
      path('source', 'dist.ini') => simple_ini({},
        ['@Starter' => { revision => 7, regenerate => 'LICENSE', releaser => '(ThisPluginDoesNotExist)',
          -remove => ['Test::ReportPrereqs', 'ConfirmRelease'] }],
      ),
      path('source', 'lib', 'DZT', 'Sample.pm') => "package DZT::Sample;\nour \$VERSION = '0.001';\n1",
    },
  },
);

# ensure no accidental uploads
die 'UploadToCPAN plugin found, aborting'
  if grep { $_->meta->name eq 'Dist::Zilla::Plugin::UploadToCPAN' } @{$tzil->plugins_with(-Releaser)};

$root_license = path($tzil->root)->child('LICENSE');

ok !$root_license->exists, 'LICENSE is not present in root';

$tzil->build;
$tzil->release;

$build_license = path($tzil->tempdir)->child('build', 'LICENSE');
ok $build_license->exists, 'LICENSE is present in release';
ok $root_license->exists, 'LICENSE was regenerated after release';
is $root_license->slurp, $build_license->slurp, 'regenerated LICENSE matches built file';

done_testing;
