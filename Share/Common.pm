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

##
sub bad_session {
    my $in = shift;
    my $s =
      CGI::Session->load( "driver:file", $in->{cookie},
        { Directory => './tmp' } )
      or die CGI::Session->errstr;
    # ���� ������ �� ������� �� true
    if ( $s->is_empty or $s->is_expired ) {
        return 1;
    }    # ���� ������� �� false
    else {
        # ������� �� ������ RhId
        $in->{rhid} = $s->param('rhid');
        return 0;
    }

    # �� ������� true
    return 1;
}

# ������� ������.
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
