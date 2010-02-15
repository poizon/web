package DB::Schema::TvChannels;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("tv_channels");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "name",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 100 },
  "code_dir_countries",
  { data_type => "CHAR", default_value => undef, is_nullable => 1, size => 3 },
  "rate_channel",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
  "tag_list",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 150,
  },
  "player_code",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("index1", ["name"]);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-02-15 12:58:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:WO5sGAj5iB/gsZHBTVOetQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
