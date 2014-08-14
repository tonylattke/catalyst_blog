package blog::Controller::year;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

blog::Controller::year - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub index :Path :Args(1) {
    my ( $self, $c, $year ) = @_;
    my @all_posts = $c->model('MyDB::Post')->search({},{});
    my @posts;
    foreach my $post (@all_posts) {
    	if ($post->date->year == $year) {
    		push @posts, $post;
    	}
    }
    $c->stash->{posts} = \@posts;
    $c->stash->{template} = 'home.tt2';
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
