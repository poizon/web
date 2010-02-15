package DB::Schema::DirCountries;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("dir_countries");
__PACKAGE__->add_columns(
  "code",
  { data_type => "CHAR", default_value => "", is_nullable => 0, size => 3 },
  "name_country",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 100 },
);
__PACKAGE__->set_primary_key("code");


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-02-15 12:58:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:BdELQ3MfW3CAeX9sEcJntg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
