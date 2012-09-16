use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  VERSION   => '0.01',
  test      => {TESTS => 't/*.t'},
  PREREQ_PM => {
 	'Mojolicious' 		=> '3.20',
 	'MongoDB'				=> '0.45',
 	'Config::Pit'			=> '0.04',
 	'JSON'					=> '2.53',
 	'Net::OAuth2'			=> '0.07'
  }
);
