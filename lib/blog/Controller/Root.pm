package blog::Controller::Root;
use Moose;
use namespace::autoclean;
use JSON;

BEGIN { extends 'Catalyst::Controller' }

__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

blog::Controller::Root - Root Controller for blog

=head1 DESCRIPTION

Root file with the control of root, 404 and json functions

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
	my ( $self, $c ) = @_;
	
	# Take all the posts
	my @posts = $c->model('MyDB::Post')->search({},{order_by => 'id desc'});
	$c->stash->{posts} = \@posts;

	# Take all the years
	$c->stash->{years} = Helpers_extra::extractYears(@posts);

	# Set the template file
	$c->stash->{template} = 'home.tt2';
}

=head2 index

The home page (/home)

=cut

sub home :Global {
	my ( $self, $c ) = @_;
	$c->res->redirect($c->uri_for('/', {}));
}

=head2 index

The post on Json page (/posts.json)

=cut

sub posts_json : Global :Path('posts.json') {
	my ( $self, $c ) = @_;

	# Check user loged
	Helpers_extra::checkLog($c,$c->user_exists);

	# Testing functions for export json
	#
	# my @posts = $c->model('MyDB::Post')->search({},{});
	# my @dictionary;
	# foreach my $post (@posts) {
	# 	my %aux = {
	# 		'id' => $post->id,
	# 		'name' => $post->name,
	# 		'text' => $post->text,
	# 		};
	# 	push @dictionary, %aux;
	# }
	# my $result = {@dictionary};
	# $c->response->body(to_json($result));

	$c->response->body(to_json({status => 'on development'}));
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    
    # Set the template file
    $c->stash->{template} = 'error.tt2';
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Tony Lattke

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
