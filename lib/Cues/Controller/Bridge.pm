package Cues::Controller::Bridge;
use Mojo::Base 'Mojolicious::Controller';

use utf8;

sub logincheck {
	my $self= shift;
	
	# Configuration check
	if(!defined($self->config()) || !defined($self->config_secret()->{session_secret})){
		$self->app->log->fatal("Cues Debug: not configured!");
		$self->render_text("Cues Debug: not configured!");
		return 0;
	}
	
	#TODO Login-check is not implemented
		
	return 1;# return true = continue after process. 
}

1;