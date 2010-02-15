package DB::Schema::TvBroadcasts;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("tv_broadcasts");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 11 },
  "id_tv_channels",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 11 },
  "time_cast",
  { data_type => "DATETIME", default_value => "", is_nullable => 0, size => 19 },
  "name_cast",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 150 },
  "descr_cast",
  {
    data_type => "TEXT",
    default_value => undef,
    is_nullable => 1,
    size => 65535,
  },
  "rate_cast",
  { data_type => "INT", default_value => undef, is_nullable => 1, size => 11 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-02-15 12:58:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:CqCYdiB/zw20qoKJa3OgQQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
