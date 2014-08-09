use utf8;
package MySchema::Result::Post;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MySchema::Result::Post

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

=head1 TABLE: C<post>

=cut

__PACKAGE__->table("post");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 text

  data_type: 'text'
  is_nullable: 1

=head2 date

  data_type: 'datetime'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "text",
  { data_type => "text", is_nullable => 1 },
  "date",
  { data_type => "datetime", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 post_comments

Type: has_many

Related object: L<MySchema::Result::PostComment>

=cut

__PACKAGE__->has_many(
  "post_comments",
  "MySchema::Result::PostComment",
  { "foreign.post_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 comments

Type: many_to_many

Composing rels: L</post_comments> -> comment

=cut

__PACKAGE__->many_to_many("comments", "post_comments", "comment");


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-08-10 01:23:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:pPZN4ZRB41uYNXDZ/N2B3g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
