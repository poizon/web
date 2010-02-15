package Share::Common;
use strict;
use warnings;
use Carp qw(croak);
use HTML::Template;

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

# готовим шаблон. внутренняя функция
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
