
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'Generalized Inverted Indexing',
  'AUTHOR' => 'Yuval Kogman <nothingmuch@cpan.org>',
  'BUILD_REQUIRES' => {
    'File::Find' => '0',
    'File::Temp' => '0',
    'MooseX::Types::Set::Object' => '0',
    'Test::More' => '0',
    'Test::TempDir' => '0',
    'ok' => '0',
    'overload' => '0'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'Search-GIN',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'Search::GIN',
  'PREREQ_PM' => {
    'Carp' => '0',
    'Data::Stream::Bulk::Util' => '0',
    'MRO::Compat' => '0',
    'Moose' => '0',
    'Moose::Role' => '0',
    'Scalar::Util' => '0',
    'Scope::Guard' => '0',
    'Set::Object' => '0',
    'Test::Deep::NoTest' => '0',
    'namespace::clean' => '0'
  },
  'VERSION' => '0.06',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



