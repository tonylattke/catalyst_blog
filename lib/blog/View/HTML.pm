package blog::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt2',
    render_die => 1,
);

=head1 NAME

blog::View::HTML - TT View for blog

=head1 DESCRIPTION

TT View for blog.

=head1 SEE ALSO

L<blog>

=head1 AUTHOR

Tony Lattke,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
