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
# ������������
###
# ������ ���������������� ����
sub read_config {
    my $class = shift;
    my %args = ( -file    => 'config.cgi', @_,);
    my %config=();
    open(CFG,"<","$args{-file}") || croak "Config error: $!";
    while(<CFG>) {
        next if(/^\#/); # ����� ���������� �����������
        chomp;
	s/^\s+//;            # ������ ��������� ��������
	s/\s+$//;            # ������ �������� ��������
	next unless length;  # ���-������ ��������?
        my($key,$value)=split(/\s*=\s*/,$_, 2);
        $config{$key}=$value if(defined($key) && defined($value));
    }
return \%config;
}

# ������� ������. ���������� �������
sub prepare_template {
    my $class = shift;
    my %args = ( -path => './template', @_,);
    # ���������� ������ HTML::Template
    return HTML::Template->new(
			       filename => $args{-template},
			       path 	=> $args{-path},
			       die_on_bad_params => 0,
				 );
}

1;
