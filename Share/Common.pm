package Share::Common;
use strict;
use warnings;
use Carp qw(croak);
use HTML::Template;
use CGI::Session ('-ip_match');

sub new {
    my $class = shift;
    my $self = bless {}, $class;
    return $self;
}

###
# Подпрограммы
###
# парсим конфигурационный файл
sub read_config {
    my $class = shift;
    my %args = ( -file    => 'config.cgi', @_,);
    my %config=();
    open(CFG,"<","$args{-file}") || croak "Config error: $!";
    while(<CFG>) {
        next if(/^\#/); # сразу пропускаем комментарии
        chomp;
	s/^\s+//;            # Убрать начальные пропуски
	s/\s+$//;            # Убрать конечные пропуски
	next unless length;  # Что-нибудь осталось?
        my($key,$value)=split(/\s*=\s*/,$_, 2);
        $config{$key}=$value if(defined($key) && defined($value));
    }
return \%config;
}

##
sub bad_session {
    my $in = shift;
    my $s =
      CGI::Session->load( "driver:file", $in->{cookie},
        { Directory => './tmp' } )
      or die CGI::Session->errstr;
    # если сессия не валидна то true
    if ( $s->is_empty or $s->is_expired ) {
        return 1;
    }    # если валидна то false
    else {
        # дергаем из сессии RhId
        $in->{rhid} = $s->param('rhid');
        return 0;
    }

    # по дефолту true
    return 1;
}

# готовим шаблон.
sub prepare_template {
    my $class = shift;
    my %args = ( -path => './template', @_,);
    # возвращаем объект HTML::Template
    return HTML::Template->new(
			       filename => $args{-template},
			       path 	=> $args{-path},
			       die_on_bad_params => 0,
				 );
}

1;
