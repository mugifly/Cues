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
	$self->plugin('config', {file => './cues.conf'});
	
	# Load secret configuration (OAuth consumer secret, session etc...)
	$self->attr('config_secret' => sub {	Config::Pit::pit_get('cues') });
	$self->helper('config_secret' => sub{ shift->app->config_secret });
	
	# Connect to Database
	$self->attr('db' => sub { 
        MongoDB::Connection
			->new(host => $self->config()->{database}->{host})
			->get_database($self->config()->{database}->{name});
	});
	$self->helper('db' => sub { shift->app->db });
	
	# Set session-cookie settings (secret, expires)
	if(defined($self->app->config_secret()->{session_secret})){
		$self->secret('cues'.$self->app->config_secret()->{session_secret});
	}
	if(defined($self->app->config_secret()->{session_expires})){
		$self->session(expiration => $self->app->config_secret->{session_expires});
	}else{
		$self->session(expiration => 2678400);
	}
	
	# Router and Set namespace
	my $r = $self->routes;
	$r->namespace('Cues::Controller');
	
	# Bridge
	$r = $r->bridge->to( cb => sub {
		my $self = shift;
		
		# Configuration check
		if(!defined($self->config()) || !defined($self->config_secret()->{session_secret})){
			$self->app->log->fatal("Cues Debug: not configured!");
			$self->render_text("Cues Debug: not configured!");
			return 0;
		}
		
		return 1;# return true = continue after process. 
	});
	
	# Normal route to controller
	$r->route('/')->to('top#welcome');
}

1;
