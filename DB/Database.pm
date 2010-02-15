package DB::Database;

use strict;
use warnings;

use lib qw(..);
use DB::Schema;
use base 'DB::Schema';

sub connect {
    my $class = shift;
    my %args = (
                host     => 'localhost',
                db       => '',
                user     => '',
                pass     => '',
                @_,
                );
    my $self = bless {}, $class;
    $self->{connect} = DB::Schema->connect("dbi:mysql:host=$args{host};database=$args{db}",$args{user},$args{pass});
    return $self;
}

1;
