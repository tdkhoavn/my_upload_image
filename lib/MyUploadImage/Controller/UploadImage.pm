package MyUploadImage::Controller::UploadImage;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Cwd;

use strict;
use warnings;

use constant ROOT => '/home/tdkhoa/workspace/mojolicious/my_upload_image';
use constant IMAGE_LOC => 'public/assets/images';

sub index {
    my $c = shift;

    $c->stash( error => $c->flash('error') );
    $c->stash( message => $c->flash('message') );

    $c->render(template => 'upload_image');
}

sub upload_image {
    my $c = shift;

    my ( $image, $image_file );

    if ( !$c->param('upload_image')) {
        $c->flash( error => 'Please select an image to upload' );
        return $c->redirect_to('/upload-image');
    }

    return $c->redirect_to('/upload-image') unless my $upload_image = $c->param('upload_image');

    # Check for valid image extension
    if ( $upload_image->filename !~ /\.png$|\.jpg$|\.jpeg$/ ) {
        $c->flash( error => 'Please select a valid image to upload' );
        return $c->redirect_to('/upload-image');
    }


    # Upload the image
    $image = $c->req->upload('upload_image');
    $image_file = ROOT . '/' . IMAGE_LOC . '/' . $upload_image->filename;

    $image->move_to($image_file);

    $c->flash( message => 'Image uploaded successfully' );
    $c->redirect_to('/upload-image');
}

1;