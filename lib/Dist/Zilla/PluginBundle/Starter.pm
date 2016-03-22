package Dist::Zilla::PluginBundle::Starter;

use Moose;
with 'Dist::Zilla::Role::PluginBundle::Easy',
  'Dist::Zilla::Role::PluginBundle::Config::Slicer',
  'Dist::Zilla::Role::PluginBundle::PluginRemover';
use namespace::clean;

our $VERSION = '0.001';

my %revisions = (
  1 => [qw(
    GatherDir
    PruneCruft
    ManifestSkip
    MetaYAML
    MetaJSON
    License
    ReadmeAnyFromPod
    ExecDir
    ShareDir
    
    MakeMaker
    Manifest
    
    TestRelease
    RunExtraTests
    ConfirmRelease
    UploadToCPAN
  )],
);

sub configure {
  my $self = shift;
  my $revision = $self->payload->{revision} // '1';
  die "Unknown [\@Starter] revision specified: $revision\n"
    unless exists $revisions{$revision};
  $self->add_plugins(@{$revisions{$revision}});
}

__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Dist::Zilla::PluginBundle::Starter - A simple start for Dist::Zilla configuration

=head1 SYNOPSIS

  ; dist.ini
  [@Starter]           ; all that is needed to start
  revision = 1         ; always defaults to revision 1
  -remove = GatherDir  ; to use [Git::GatherDir] instead, for example
  ExecDir.dir = script ; change the directory used by [ExecDir]

=head1 DESCRIPTION

This plugin bundle for L<Dist::Zilla> is designed to do the minimal amount of
work to release a complete distribution reliably. It is similar in purpose to
L<[@Basic]|Dist::Zilla::PluginBundle::Basic>, but with additional features. It
composes the L<PluginRemover|Dist::Zilla::Role::PluginBundle::PluginRemover>
and L<Config::Slicer|Dist::Zilla::Role::PluginBundle::Config::Slicer> roles to
make it easier to extend and customize. Also, it supports bundle revisions
specified as an option, in case distribution packaging and releasing practices
change in the future.

=head1 REVISIONS

The plugin bundle currently includes only one revision.

=head2 1

Revision 1 is the default and is equivalent to using the following plugins:

  [GatherDir]
  [PruneCruft]
  [ManifestSkip]
  [MetaYAML]
  [MetaJSON]
  [License]
  [ReadmeAnyFromPod]
  [ExecDir]
  [ShareDir]
  
  [MakeMaker]
  [Manifest]
  
  [TestRelease]
  [RunExtraTests]
  [ConfirmRelease]
  [UploadToCPAN]

This revision differs from L<[@Basic]|Dist::Zilla::PluginBundle::Basic> as
follows: including L<[MetaJSON]|Dist::Zilla::Plugin::MetaJSON>; using
L<[ReadmeAnyFromPod]|Dist::Zilla::Plugin::ReadmeAnyFromPod> instead of
L<[Readme]|Dist::Zilla::Plugin::Readme>; and using
L<[RunExtraTests]|Dist::Zilla::Plugin::RunExtraTests> instead of
L<[ExtraTests]|Dist::Zilla::Plugin::ExtraTests>.

=head1 BUGS

Report any issues on the public bugtracker.

=head1 AUTHOR

Dan Book <dbook@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2016 by Dan Book.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=head1 SEE ALSO

L<Dist::Zilla>, L<Dist::Zilla::PluginBundle::Basic>
