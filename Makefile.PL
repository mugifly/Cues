use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  VERSION   => '0.01',
  test      => {TESTS => 't/*.t'},
  PREREQ_PM => {
 	'Mojolicious' 		=> '3.20'
  }
);