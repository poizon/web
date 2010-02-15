#!/usr/bin/perl -w
# основной файл для обработки интерфейса пользователя
#
$|=1;
use lib qw(.);
use strict;
use warnings;
use CGI::Simple;
use DB::Database;
use Share::Common;
# объекты
my $c = Share::Common->new();
my $q = CGI::Simple->new();
# входные данные
my %in = $q->Vars();
$in{cookie} = $q->cookie('CGISESSID');# сохраняем куки с сессией
# конфиг
my $config = $c->read_config(-file => 'config.cgi');
# выходной html
my $html;
# коннект к БД
my $db = DB::Database->connect(
        host => $config->{hostname},
        db   => $config->{database},
        user => $config->{username},
        pass => $config->{password},
    );
# если сессия не верна и это не логин - то принудительно отправляем на логин
if($c->bad_session(\%in) && $in{act} ne 'login') {
    $in{act}='default';
    $in{cookie} = undef;
}

# действие в интерфейсе
my %act = (
           default => \&main,
           login   => \&login,
           logout  => \&logout,
            );

# вызов нужной функции
if(exists $in{'mode'}) {
    $html = $act{$in{'mode'}}->($db, \%in, $config);
} else {
    $html = $act{'default'}->($db, \%in, $config);
}

# выводим страницу
print $q->header(-charset => 'utf-8', -cookie => $in{cookie});
print $html;


