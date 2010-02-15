package DB::Schema::TvUsers;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("tv_users");
__PACKAGE__->add_columns(
  "id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 11 },
  "login",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 45 },
  "pass",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 50 },
  "first_name",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 60 },
  "last_name",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 60 },
  "email",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 70 },
  "code_dir_countries",
  { data_type => "CHAR", default_value => "RU", is_nullable => 0, size => 3 },
  "city",
  {
    data_type => "VARCHAR",
    default_value => undef,
    is_nullable => 1,
    size => 50,
  },
  "date_reg",
  { data_type => "DATETIME", default_value => "", is_nullable => 0, size => 19 },
);
__PACKAGE__->set_primary_key("id", "login");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-02-15 12:58:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:MnyUKv5U4lufmDvCbsXrhw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
