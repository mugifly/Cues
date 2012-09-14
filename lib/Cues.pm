package Cues;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
	my $self = shift;
	
	# Documentation browser under "/perldoc"
	$self->plugin('PODRenderer');
	
	# Router
	my $r = $self->routes;
	
	# Set namespace
	$r->namespace('Cues::Controller');
	
	# Normal route to controller
	$r->get('/')->to('top#welcome');
}

1;
