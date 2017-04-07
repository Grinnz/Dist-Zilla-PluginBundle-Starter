package Dist::Zilla::MintingProfile::Starter;

use Moose;
with 'Dist::Zilla::Role::MintingProfile::ShareDir';
use namespace::clean;

our $VERSION = '0.006';

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
will be populated in the C<dist.ini> and documentation from the current dzil
C<config.ini>, which can be initialized using
L<C<dzil setup>|Dist::Zilla::App::Command::setup>. The version is initialized
statically as C<0.001>. See L<Dist::Zilla::PluginBundle::Starter/"Versions">
for ways to automatically manage distribution versions between releases with
L<Dist::Zilla>.

=head1 CUSTOMIZING

It's easy to create your own local version of this (or any other) minting
profile which you can customize as you choose. First create a new directory in
C<profiles> in your dzil configuration folder:

  $ mkdir -p ~/.dzil/profiles/myminter

Then, copy the contents from the profile you want (such as the
C<profiles/default> directory of this distribution). Modify the copied files to
your liking, and then you can use it to mint a distribution.

  $ dzil new -p myminter My::New::Dist

You can also specify a default provider (C<-P> option) or profile (C<-p>
option) in your dzil config (C<~/.dzil/config.ini>).

  ; config.ini
  [%Mint]
  profile = myminter

  ; or
  [%Mint]
  provider = Starter

  $ dzil new My::New::Dist # now uses the specified provider and/or profile

If no provider or profile is configured or specified, C<dzil new> will use the
C<default> local profile, or the default C<[@Basic]> profile shipped with
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
