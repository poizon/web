package Schema;
# ��� ��������� �����
# perl -MDBIx::Class::Schema::Loader=dump_to_dir:BES -MBES::Schema -e "BES::Schema->connection()"
use strict;
use warnings;
  
use base qw/DBIx::Class::Schema::Loader/;
    
 __PACKAGE__->loader_options(
            debug         => 1,
            really_erase_my_files => 1,
              );
__PACKAGE__->connection('dbi:mysql:host:localhost;database=lookweb', 'lookweb','l00kw3b');
                
1;