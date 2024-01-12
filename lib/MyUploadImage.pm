package MyUploadImage;
use Mojo::Base 'Mojolicious', -signatures;

# This method will run once at server start
sub startup ($self) {

  # Load configuration from config file
  my $config = $self->plugin('NotYAMLConfig');

  # Configure the application
  $self->secrets($config->{secrets});

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('Example#welcome');
  $r->get('/upload-image')->to(controller => 'UploadImage', action => 'index');
  $r->post('/upload-image')->to(controller => 'UploadImage', action => 'upload_image');
}

1;
