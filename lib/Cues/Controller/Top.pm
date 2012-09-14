package Cues::Controller::Top;
use Mojo::Base 'Mojolicious::Controller';

use utf8;

sub welcome {
	my $self = shift;
	
	$self->render();
}

1;
