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

sub index :Path :Args(1) {
    my ( $self, $c, $id ) = @_;
    $c->stash->{post} = $c->model('MyDB::Post')->find($id);
    $c->stash->{comments} = $c->model('MyDB::Comment');
    $c->stash->{template} = 'post.tt2';
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
