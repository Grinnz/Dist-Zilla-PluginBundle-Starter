package Dist::Zilla::PluginBundle::Starter;

use Moose;
with 'Dist::Zilla::Role::PluginBundle::Easy',
  'Dist::Zilla::Role::PluginBundle::Config::Slicer',
  'Dist::Zilla::Role::PluginBundle::PluginRemover';
use namespace::clean;

our $VERSION = '0.003';

# Revisions can include entries with the standard plugin name, array ref of plugin/name/config,
# or coderefs which are passed the pluginbundle object and return one of these formats.
my %revisions = (
  1 => [
    'GatherDir',
    'PruneCruft',
    'ManifestSkip',
    'MetaConfig',
    'MetaProvides::Package',
    ['MetaNoIndex' => { directory => [qw(t xt inc share eg examples)] }],
    'MetaYAML',
    'MetaJSON',
    'License',
    'ReadmeAnyFromPod',
    'ExecDir',
    'ShareDir',
    'PodSyntaxTests',
    'Test::ReportPrereqs',
    ['Test::Compile' => { xt_mode => 1 }],
    'MakeMaker',
    'Manifest',
    'TestRelease',
    'RunExtraTests',
    'ConfirmRelease',
    'UploadToCPAN',
  ],
  2 => [ # experimental
    'GatherDir',
    'PruneCruft',
    'ManifestSkip',
    'MetaConfig',
    ['MetaProvides::Package' => { inherit_version => 0 }],
    ['MetaNoIndex' => { directory => [qw(t xt inc share eg examples)] }],
    'MetaYAML',
    'MetaJSON',
    'License',
    'ReadmeAnyFromPod',
    'ExecDir',
    'ShareDir',
    'PodSyntaxTests',
    'Test::ReportPrereqs',
    ['Test::Compile' => { xt_mode => 1 }],
    'MakeMaker',
    'Manifest',
    'TestRelease',
    'RunExtraTests',
    'ConfirmRelease',
    'UploadToCPAN',
  ],
);

sub configure {
  my $self = shift;
  my $revision = $self->payload->{revision};
  $revision = '1' unless defined $revision;
  my @plugins = @{$self->get_revision($revision)};
  foreach my $plugin (@plugins) {
    $plugin = $plugin->($self) if ref $plugin eq 'CODE';
    if ($ENV{FAKE_RELEASE}) {
      if (ref $plugin eq 'ARRAY' and @$plugin and $plugin->[0] eq 'UploadToCPAN') {
        $plugin = ['FakeRelease', @$plugin[1..$#$plugin]];
      } elsif (!ref $plugin and $plugin eq 'UploadToCPAN') {
        $plugin = 'FakeRelease';
      }
    }
  }
  $self->add_plugins(@plugins);
}

sub get_revision {
  my ($self, $revision) = @_;
  die "Unknown [\@Starter] revision specified: $revision\n"
    unless exists $revisions{$revision};
  return $revisions{$revision};
}

__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Dist::Zilla::PluginBundle::Starter - A minimal Dist::Zilla plugin bundle

=head1 SYNOPSIS

  ; dist.ini
  name    = My-Cool-Distribution
  author  = Example Jones <jones@example.com>
  license = Perl_5
  copyright_holder = Example Jones
  copyright_year   = 2016
  version = 0.001
  
  [@Starter]           ; all that is needed to start
  revision = 1         ; always defaults to revision 1
  -remove = GatherDir  ; to use [Git::GatherDir] instead, for example
  ExecDir.dir = script ; change the directory used by [ExecDir]

=head1 DESCRIPTION

The C<[@Starter]> plugin bundle for L<Dist::Zilla> is designed to do the
minimal amount of work to release a complete distribution reliably. It is
similar in purpose to L<[@Basic]|Dist::Zilla::PluginBundle::Basic>, but with
additional features to stay up to date and allow greater customization. The
selection of included plugins is intended to be unopinionated and unobtrusive,
so that it is usable for any well-formed CPAN distribution.

C<[@Starter]> composes the L<PluginRemover|Dist::Zilla::Role::PluginBundle::PluginRemover>
and L<Config::Slicer|Dist::Zilla::Role::PluginBundle::Config::Slicer> roles to
make it easier to customize and extend. Also, it supports bundle revisions
specified as an option, in order to incorporate future changes to distribution
packaging and releasing practices. Existing revisions will not be changed to
preserve backwards compatibility.

The C<FAKE_RELEASE> environment variable is supported as in L<Dist::Milla> and
L<Minilla>. It replaces the L<[UploadToCPAN]|Dist::Zilla::Plugin::UploadToCPAN>
plugin with L<[FakeRelease]|Dist::Zilla::Plugin::FakeRelease>, to test the
release process (including any version bumping and commits!) without actually
uploading to CPAN.

  $ FAKE_RELEASE=1 dzil release

Migrating from C<[@Basic]> is easy for most cases. Most of the bundle is the
same, so just make sure to remove any extra plugins that C<[@Starter]> already
includes, and configure the included plugins if needed (see L</"CONFIGURING">).
Migrating a more complex set of plugins, including some that interact with the
additional generated files, may require more careful consideration.

For one-line initialization of a new C<[@Starter]>-based distribution, try
L<Dist::Zilla::MintingProfile::Starter>.

=head1 REVISIONS

The C<[@Starter]> plugin bundle currently includes only one revision.

=head2 Revision 1

Revision 1 is the default and is equivalent to using the following plugins:

=over 2

=item L<[GatherDir]|Dist::Zilla::Plugin::GatherDir>

=item L<[PruneCruft]|Dist::Zilla::Plugin::PruneCruft>

=item L<[ManifestSkip]|Dist::Zilla::Plugin::ManifestSkip>

=item L<[MetaConfig]|Dist::Zilla::Plugin::MetaConfig>

=item L<[MetaProvides::Package]|Dist::Zilla::Plugin::MetaProvides::Package>

=item L<[MetaNoIndex]|Dist::Zilla::Plugin::MetaNoIndex>

  directory = t
  directory = xt
  directory = inc
  directory = share
  directory = eg
  directory = examples

=item L<[MetaYAML]|Dist::Zilla::Plugin::MetaYAML>

=item L<[MetaJSON]|Dist::Zilla::Plugin::MetaJSON>

=item L<[License]|Dist::Zilla::Plugin::License>

=item L<[ReadmeAnyFromPod]|Dist::Zilla::Plugin::ReadmeAnyFromPod>

=item L<[ExecDir]|Dist::Zilla::Plugin::ExecDir>

=item L<[ShareDir]|Dist::Zilla::Plugin::ShareDir>

=item L<[PodSyntaxTests]|Dist::Zilla::Plugin::PodSyntaxTests>

=item L<[Test::ReportPrereqs]|Dist::Zilla::Plugin::Test::ReportPrereqs>

=item L<[Test::Compile]|Dist::Zilla::Plugin::Test::Compile>

  xt_mode = 1

=item L<[MakeMaker]|Dist::Zilla::Plugin::MakeMaker>

=item L<[Manifest]|Dist::Zilla::Plugin::Manifest>

=item L<[TestRelease]|Dist::Zilla::Plugin::TestRelease>

=item L<[RunExtraTests]|Dist::Zilla::Plugin::RunExtraTests>

=item L<[ConfirmRelease]|Dist::Zilla::Plugin::ConfirmRelease>

=item L<[UploadToCPAN]|Dist::Zilla::Plugin::UploadToCPAN>

=back

This revision differs from L<[@Basic]|Dist::Zilla::PluginBundle::Basic> as
follows: using L<[ReadmeAnyFromPod]|Dist::Zilla::Plugin::ReadmeAnyFromPod>
instead of L<[Readme]|Dist::Zilla::Plugin::Readme>; using
L<[RunExtraTests]|Dist::Zilla::Plugin::RunExtraTests> instead of
L<[ExtraTests]|Dist::Zilla::Plugin::ExtraTests>; and including the following
additional plugins: L<[MetaJSON]|Dist::Zilla::Plugin::MetaJSON>,
L<[MetaConfig]|Dist::Zilla::Plugin::MetaConfig>,
L<[MetaProvides::Package]|Dist::Zilla::Plugin::MetaProvides::Package>,
L<[MetaNoIndex]|Dist::Zilla::Plugin::MetaNoIndex>,
L<[PodSyntaxTests]|Dist::Zilla::Plugin::PodSyntaxTests>,
L<[Test::ReportPrereqs]|Dist::Zilla::Plugin::Test::ReportPrereqs>,
L<[Test::Compile]|Dist::Zilla::Plugin::Test::Compile>.

=head1 CONFIGURING

By using the L<PluginRemover|Dist::Zilla::Role::PluginBundle::PluginRemover> or
L<Config::Slicer|Dist::Zilla::Role::PluginBundle::Config::Slicer> role options,
the C<[@Starter]> bundle's included plugins can be customized as desired. Here
are some examples:

=head2 GatherDir

If the distribution is using git source control, it is often helpful to replace
the default L<[GatherDir]|Dist::Zilla::Plugin::GatherDir> plugin with
L<[Git::GatherDir]|Dist::Zilla::Plugin::Git::GatherDir>.

  [Git::GatherDir]
  [@Starter]
  -remove = GatherDir

=head2 Readme

The L<[ReadmeAnyFromPod]|Dist::Zilla::Plugin::ReadmeAnyFromPod> plugin
generates a plaintext README from the POD text in the distribution's
L<Dist::Zilla/"main_module"> by default, but can be configured to look
elsewhere. The standard README should always be plaintext, but in order to
generate a non-plaintext README in addition, the plugin can simply be used a
second time. Note that POD-format READMEs should not be included in the
distribution build because they will get indexed and installed due to an oddity
in CPAN installation tools.

  [@Starter]
  ReadmeAnyFromPod.source_filename = bin/foobar
  
  [ReadmeAnyFromPod / Markdown_Readme]
  type = markdown
  filename = README.md
  
  [ReadmeAnyFromPod / Pod_Readme]
  type = pod
  location = root ; do not include pod readmes in the build!

=head2 ExecDir

Some distributions use the C<script> directory instead of C<bin> (the
L<[ExecDir]|Dist::Zilla::Plugin::ExecDir> default) for executable scripts.

  [@Starter]
  ExecDir.dir = script

=head2 MetaNoIndex

A distribution may include additional files or directories that should not have
their contents indexed as CPAN modules. (See
L<Config::MVP::Slicer/"CONFIGURATION SYNTAX"> for an explanation of the
subscripts for slicing array attributes.)

  [@Starter]
  MetaNoIndex.file[0] = eggs/FooBar.pm
  MetaNoIndex.directory[a] = eggs
  MetaNoIndex.directory[b] = bacon

=head2 MetaProvides

The L<[MetaProvides::Package]|Dist::Zilla::Plugin::MetaProvides::Package>
plugin will use the distribution's version as the version of each module when
populating the C<provides> metadata by default. If the distribution does not
maintain uniform module versions, the plugin can be configured to use each
module's hardcoded version.

  [@Starter]
  MetaProvides::Package.inherit_version = 0

With this option set, it will use the distribution version as a fallback for
any module where it can't find a version. This can also be overridden, so that
these modules will simply not have a version specified in metadata.

  [@Starter]
  MetaProvides::Package.inherit_version = 0
  MetaProvides::Package.inherit_missing = 0

=head1 EXTENDING

This bundle includes a basic set of plugins for releasing a distribution, but
there are many more common non-intrusive tasks that L<Dist::Zilla> can help
with simply by using additional plugins in the C<dist.ini>.

=head2 Name

To automatically set the distribution name from the current directory, use
L<[NameFromDirectory]|Dist::Zilla::Plugin::NameFromDirectory>.

=head2 License and Copyright

To extract the license and copyright information from the main module, and
optionally set the author as well, use
L<[LicenseFromModule]|Dist::Zilla::Plugin::LicenseFromModule>.

=head2 Versions

A common approach to maintaining versions in L<Dist::Zilla> managed
distributions is to automatically extract the distribution's version from the
main module, maintain uniform module versions, and bump the version after a
release. This can be accomplished with either
L<[RewriteVersion]|Dist::Zilla::Plugin::RewriteVersion> with
L<[BumpVersionAfterRelease]|Dist::Zilla::Plugin::BumpVersionAfterRelease>, or
L<[VersionFromModule]|Dist::Zilla::Plugin::VersionFromModule> with
L<[ReversionOnRelease]|Dist::Zilla::Plugin::ReversionOnRelease>. Don't mix
these two approaches!

=head2 Changelog

To automatically add the new release version to the distribution changelog,
use L<[NextRelease]|Dist::Zilla::Plugin::NextRelease>. To ensure the release
has changelog entries, use
L<[CheckChangesHasContent]|Dist::Zilla::Plugin::CheckChangesHasContent>.

=head2 Git

To better integrate with a git workflow, use the plugins from
L<[@Git]|Dist::Zilla::PluginBundle::Git>. To automatically add contributors to
metadata from git commits, use L<[Git::Contributors]|Dist::Zilla::Plugin::Git::Contributors>.

=head2 Resources

To automatically set resource metadata from an associated GitHub repository,
use L<[GithubMeta]|Dist::Zilla::Plugin::GithubMeta>. To set resource metadata
manually, use L<[MetaResources]|Dist::Zilla::Plugin::MetaResources>.

=head2 Prereqs

To automatically set distribution prereqs from a cpanfile, use
L<[Prereqs::FromCPANfile]|Dist::Zilla::Plugin::Prereqs::FromCPANfile>. To
specify prereqs manually, use L<[Prereqs]|Dist::Zilla::Plugin::Prereqs>.

=head1 BUGS

Report any issues on the public bugtracker.

=head1 AUTHOR

Dan Book <dbook@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2016 by Dan Book.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=head1 SEE ALSO

L<Dist::Zilla>, L<Dist::Zilla::PluginBundle::Basic>,
L<Dist::Zilla::MintingProfile::Starter>
