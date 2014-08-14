package blog::Controller::post;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

blog::Controller::post - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub current_time {
	my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
    $year += 1900;
    $mon++;
    return "$year-$mon-$mday $hour:$min:$sec";
}

sub index :Path :Args(1) {
    my ( $self, $c, $id ) = @_;
    $c->stash->{post} = $c->model('MyDB::Post')->find($id);
    $c->stash->{comments} = $c->model('MyDB::Comment')->search({post => $id});
    $c->stash->{template} = 'post.tt2';
}


sub _new :Local :Path('new') {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'post_new.tt2';
}

sub _new_do :Local :Path('new_do') {
    my ( $self, $c ) = @_;
	$c->model('MyDB::Post')->create(
		{
			name => $c->request->params->{name}, 
			text => $c->request->params->{text}, 
			date => current_time()
		}
	);
	$c->flash->{status_msg} = "Create Post Successfull.";
	$c->res->redirect($c->uri_for('/', {}));
}

sub edit :Local :Args(1) {
    my ( $self, $c, $id ) = @_;
    $c->stash->{post} = $c->model('MyDB::Post')->find($id);
    $c->stash->{comments} = $c->model('MyDB::Comment');
    $c->stash->{template} = 'post_edit.tt2';
}

sub modify :Local :Args(1) {
    my ( $self, $c, $id ) = @_;
    my $post = $c->model('MyDB::Post')->find($id);
	$post->name($c->request->params->{name});
	$post->text($c->request->params->{text});
	$post->date(current_time());
	$post->update;
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
			date => current_time()
		}
	);
    
    # Update post
    $c->res->redirect($c->uri_for("/post/$id", {}));
}

sub delete :Local :Args(1) {
    my ( $self, $c, $id ) = @_;
    my $post = $c->model('MyDB::Post')->find($id);
	$post->delete;
    $c->res->redirect($c->uri_for("/", {}));
}

=encoding utf8

=head1 AUTHOR

Tony Lattke,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
