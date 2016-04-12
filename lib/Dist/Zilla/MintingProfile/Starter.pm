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

  # setup is only needed the first time
  $ dzil setup
  $ dzil new -P Starter My::New::Dist

=head1 DESCRIPTION

This minting profile creates a minimal new distribution consisting of a basic
C<dist.ini> using the L<[@Starter]|Dist::Zilla::PluginBundle::Starter> plugin
bundle, and a skeleton for the main module and documentation. The author,
license, and copyright will be populated by the current dzil C<config.ini>,
which can be initialized using C<dzil setup>.

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
