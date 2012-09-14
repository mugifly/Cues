package Cues;
use Mojo::Base 'Mojolicious';

use MongoDB;

use Config::Pit ();

# This method will run once at server start
sub startup {
	my $self = shift;
	
	# Documentation browser under "/perldoc" #TODO Please remove
	$self->plugin('PODRenderer');
	
	# Load normal configuration
	$self->attr('config' => sub {	$self->plugin('config', {file => './cues.conf'})	});
	$self->helper('config' => sub{ shift->app->config });
	
	# Load secret configuration (OAuth consumer secret, etc...)
	$self->attr('config_secret' => sub {	$self->Config::Pit::pit_get('cues') });
	$self->helper('config_secret' => sub{ shift->app->config_secret });
	
	# Connect to Database
	$self->attr('db' => sub { 
        MongoDB::Connection
			->new(host => $self->config()->{database}->{host})
			->get_database($self->config()->{database}->{name});
	});
	$self->helper('db' => sub { shift->app->db });
	
	# Router
	my $r = $self->routes;
	
	# Set namespace
	$r->namespace('Cues::Controller');
	
	# Normal route to controller
	$r->route('/')->to('top#welcome');
}

1;
