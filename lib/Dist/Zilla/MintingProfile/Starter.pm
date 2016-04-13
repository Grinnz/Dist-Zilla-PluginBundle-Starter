package Dist::Zilla::MintingProfile::Starter;

use Moose;
with 'Dist::Zilla::Role::MintingProfile::ShareDir';
use namespace::clean;

our $VERSION = '0.002';

__PACKAGE__->meta->make_immutable;
1;

=head1 NAME

Dist::Zilla::MintingProfile::Starter - A minimal Dist::Zilla minting profile

=head1 SYNOPSIS

  # setup only needs to be run once to set up your dzil config
  $ dzil setup
  $ dzil new -P Starter My::New::Dist

=head1 DESCRIPTION

This minting profile for L<C<dzil new>|Dist::Zilla::App::Command::new> creates
a minimal new distribution consisting of a basic C<dist.ini> using the
L<[@Starter]|Dist::Zilla::PluginBundle::Starter> plugin bundle, and a skeleton
for the main module and its documentation. The author, license, and copyright
will be populated in the C<dist.ini> and documentation by the current dzil
C<config.ini>, which can be initialized using
L<C<dzil setup>|Dist::Zilla::App::Command::setup>. The version is initialized
statically as C<0.001>. See L<Dist::Zilla::PluginBundle::Starter/"Versions">
for ways to automatically manage distribution versions between releases with
L<Dist::Zilla>.

=head1 BUGS

Report any issues on the public bugtracker.

=head1 AUTHOR

Dan Book <dbook@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2016 by Dan Book.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)

=head1 SEE ALSO

L<Dist::Zilla>, L<Dist::Zilla::PluginBundle::Starter>
