package Cues::Controller::Top;
use Mojo::Base 'Mojolicious::Controller';

sub welcome {
	my $self = shift;
	
	$self->render(
		message => 'Welcome to the Mojolicious real-time web framework!');
}

1;
