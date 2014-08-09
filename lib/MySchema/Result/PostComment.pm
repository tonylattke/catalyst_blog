use utf8;
package MySchema::Result::PostComment;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MySchema::Result::PostComment

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<post_comment>

=cut

__PACKAGE__->table("post_comment");

=head1 ACCESSORS

=head2 post_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 comment_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "post_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "comment_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</post_id>

=item * L</comment_id>

=back

=cut

__PACKAGE__->set_primary_key("post_id", "comment_id");

=head1 RELATIONS

=head2 comment

Type: belongs_to

Related object: L<MySchema::Result::Comment>

=cut

__PACKAGE__->belongs_to(
  "comment",
  "MySchema::Result::Comment",
  { id => "comment_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 post

Type: belongs_to

Related object: L<MySchema::Result::Post>

=cut

__PACKAGE__->belongs_to(
  "post",
  "MySchema::Result::Post",
  { id => "post_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-08-10 01:23:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:zh/or7cviaqpNLLAUjNnHQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
