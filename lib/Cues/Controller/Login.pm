package Cues::Controller::Login;
use Mojo::Base 'Mojolicious::Controller';

use utf8;

sub auth_google_redirect {
	my $self= shift;
	
	$self->app->plugin('Cues::Helper::Login');
	my $oauth = $self->oauth_client_google;
	
	$self->redirect_to($oauth->authorize_url);
}

sub auth_google_callback {
	my $self = shift;
	
	$self->app->plugin('Cues::Helper::Login');
	my $oauth = $self->oauth_client_google;
	
	my $access_token;
	eval {
		$access_token = $oauth->get_access_token($self->param('code'));
	};
	
	if($@){
		$self->redirect_to('/?token_invalid');
		return;
	}
	
	my $response = $access_token->get('https://www.googleapis.com/oauth2/v1/userinfo');
	if ($response->is_success) {
		$self->render_json({token => $access_token->{access_token}, email => $response->decoded_content()});
	} else {
		$self->redirect_to('/?oauth_failed');
	}
}

1;
