package DB::Schema::TvChannelsTags;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("Core");
__PACKAGE__->table("tv_channels_tags");
__PACKAGE__->add_columns(
  "id_tv_channels",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 11 },
  "id_dir_tags",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 11 },
);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-02-15 12:58:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:L9A3zmvKeZOwXB+e+EM2ww


# You can replace this text with custom content, and it will be preserved on regeneration
1;
