package blog::Controller::logout;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

blog::Controller::logout - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
 
    # Clear the user's state
    $c->logout;
 	$c->flash->{status_msg} = "Logout Successfull.";

    # Send the user to the starting point
    $c->response->redirect($c->uri_for('/'));
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
