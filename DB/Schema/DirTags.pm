package DB::Schema::DirTags;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("dir_tags");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "name_tag",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 50 },
  "count_tag",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("name_tag", ["name_tag"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-02-15 12:58:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:oWbEF5ml2tVPjWgvuZ0Rbg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
