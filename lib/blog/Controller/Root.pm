package blog::Controller::Root;
use Moose;
use namespace::autoclean;
use JSON;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

blog::Controller::Root - Root Controller for blog

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
    my @posts = $c->model('MyDB::Post')->search({},{order_by => 'id desc'});
    $c->stash->{posts} = \@posts;
 	my @years;
 	if (@posts > 0) {
 		my $newer_year = $posts[0]->date->year;
 		my $older_year = $posts[-1]->date->year;
 		push @years, $newer_year;
 		if ($older_year != $newer_year) {
 			for (my $x = $newer_year; $x >= $older_year; $x--) {
				push @years, $x;
			}
 		}
 	}
	$c->stash->{years} = \@years;
    $c->stash->{template} = 'home.tt2';
}

sub home :Global {
	my ( $self, $c ) = @_;
	$c->res->redirect($c->uri_for('/', {}));
}

sub posts_json : Global {
	my ( $self, $c ) = @_;
	my @posts = $c->model('MyDB::Post')->search({},{});
	my @dictionary;
	foreach my $post (@posts) {
		my %aux = {
			'id' => $post->id,
			'name' => $post->name,
			'text' => $post->text,
			};
		push @dictionary, %aux;
	}
	my $result = {@dictionary};
	$c->response->body(to_json($result));
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Tony Lattke,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
