package blog::Controller::post;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

blog::Controller::post - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller for posts.

=head2 index

=cut

sub index :Path :Args(1) {
    my ( $self, $c, $id ) = @_;

    # Take the post by id
    $c->stash->{post} = $c->model('MyDB::Post')->find($id);

    # Take all the years
    my @posts = $c->model('MyDB::Post')->search({},{order_by => 'id desc'});
    $c->stash->{years} = Helpers_extra::extractYears(@posts);

    # Take all the comments of the post
    $c->stash->{comments} = $c->model('MyDB::Comment')->search({post => $id});
    
    # Set the template file
    $c->stash->{template} = 'post.tt2';
}


sub _new :Local :Path('new') {
    my ( $self, $c ) = @_;

    # Check user loged
    Helpers_extra::checkLog($c,$c->user_exists);

    # Take all the years
    my @posts = $c->model('MyDB::Post')->search({},{order_by => 'id desc'});
    $c->stash->{years} = Helpers_extra::extractYears(@posts);

    # Set the template file
    $c->stash->{template} = 'post_new.tt2';
}

sub _new_do :Local :Path('new_do') {
    my ( $self, $c ) = @_;
	
    # Check user loged
    Helpers_extra::checkLog($c,$c->user_exists);

    $c->model('MyDB::Post')->create(
		{
			name => $c->request->params->{name}, 
			text => $c->request->params->{text}, 
			date => Helpers_extra::currentTime()
		}
	);
	$c->flash->{status_msg} = "Create Post Successfull.";
	$c->res->redirect($c->uri_for('/', {}));
}

sub edit :Local :Args(1) {
    my ( $self, $c, $id ) = @_;
    
    # Check user loged
    Helpers_extra::checkLog($c,$c->user_exists);

    # Take all the years
    my @posts = $c->model('MyDB::Post')->search({},{order_by => 'id desc'});
    $c->stash->{years} = Helpers_extra::extractYears(@posts);

    $c->stash->{post} = $c->model('MyDB::Post')->find($id);
    $c->stash->{template} = 'post_edit.tt2';
}

sub modify :Local :Args(1) {
    my ( $self, $c, $id ) = @_;
    
    # Check user loged
    Helpers_extra::checkLog($c,$c->user_exists);

    # Take the post by id and update attributes
    my $post = $c->model('MyDB::Post')->find($id);
	$post->name($c->request->params->{name});
	$post->text($c->request->params->{text});
	$post->date(Helpers_extra::currentTime());
	$post->update;

    # Update post
    $c->res->redirect($c->uri_for("/post/$id", {}));
}

sub make_comment :Local :Args(1) {
    my ( $self, $c, $id ) = @_;
    
    # Create comment
    my $comment = $c->model('MyDB::Comment')->create(
		{
			post => $id,
			name => $c->request->params->{comment_name}, 
			text => $c->request->params->{comment_text}, 
			date => Helpers_extra::currentTime()
		}
	);
    
    # Update post
    $c->res->redirect($c->uri_for("/post/$id", {}));
}

sub delete :Local :Args(1) {
    my ( $self, $c, $id ) = @_;

    # Check user loged
    Helpers_extra::checkLog($c,$c->user_exists);

    # Delete the post by id
    my $post = $c->model('MyDB::Post')->find($id);
	$post->delete;

    # Redirect to home
    $c->res->redirect($c->uri_for("/", {}));
}

=encoding utf8

=head1 AUTHOR

Tony Lattke

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
