# $Id: Format.pm,v 1.8 2003/03/16 18:03:19 philip Exp $
# $Name:  $

package Date::Format;
use strict;
use warnings FATAL => 'all';
use Carp;

use Date::Util;
use Util::Misc;

require Exporter;
#use AutoLoader qw(AUTOLOAD);

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
  date_format
);

our $VERSION = do { my @r = (q$Revision: 1.8 $ =~ /\d+/g); sprintf " %d." . "%02d" x $#r, @r };

sub date_format {

  my ($date, $mask) = @_;
  my ($year, $month, $mday, $wday);

  ### 1 and exactly 1 regex for each format we support

  ## As returned by date_get()
  ## [2003 1 2 3] 
  if ($date =~ /(\d{4})\s(\d{1,2})\s(\d{1,2})\s([0-6])/o) {
    ($year, $month, $mday, $wday) = ($1, $2, $3, $4);
  }
  ## As returned by MySQL
  ## [2003-01-02]
  elsif ($date =~ /(\d{4})\-(\d{2})\-(\d{2})/o) {
    ($year, $month, $mday, $wday) = ($1, $2, $3, undef);
    $mday =~ s/^0+//;
    $wday = &date_weekday_get($year, $month, $mday);
  }
  else {
    confess("$date is an unsupported format");
    return undef;
  }

  ### Create variables used in masks
  my $yyyy       	    = $year              				;
  my $yy         	    = $yyyy =~ /(\d\d)$/ 				;
  my $dd_2       	    = $mday              				;
  my $dd         	    = $mday              				;
  my $month_full 	    = $r_months_full{$month}       			;
  my $month_abbr 	    = $r_months_abbrev{$month}                  	;
  my $mm         	    = $month                             	        ;
  my $mm_2       	    = $month                 	                        ;
  my $weekday_full 	    = $r_weekdays_full{$wday}                           ;
  my $weekday_abbrev 	    = $r_weekdays_abbrev{$wday}                         ;	 

  $dd_2 = &pad($dd_2, 2, '0', 'front');
  $mm_2 = &pad($mm_2, 2, '0', 'front');

  ### Replace the masks with there values leaving anything else untouched
  $mask =~ s/yyyy/$yyyy/g;
  $mask =~ s/yy/$yy/g;
  $mask =~ s/dd_2/$dd_2/g;
  $mask =~ s/dd/$dd/g;
  $mask =~ s/month/$month_full/g;
  $mask =~ s/mon/$month_abbr/g;
  $mask =~ s/mm_2/$mm_2/g;
  $mask =~ s/mm/$mm/g;
  $mask =~ s/weekday/$weekday_full/g;
  $mask =~ s/wday/$weekday_abbrev/g;

  return $mask;
}

1;
__END__
=head1 NAME
    
Date::Format - Format a Date
    
=head1 SYNOPSIS   
    
  use Date::Format;
  use Date::Current;
  my $datef = &date_format(&date_get(), "yyyy/mm/dd hh12:mi:ss ampm");
 
=head2 EXPORT
  date_format();

=head1 AUTHOR

Philip M. Gollucci, E<lt>philip@p6m7g8.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by Philip M. Gollucci

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 ChangeLog

 $Log: Format.pm,v $
 Revision 1.8  2003/03/16 18:03:19  philip
 Removed # from ChangeLog sections in perldocumation so it formats correctly

 Revision 1.7  2003/03/16 17:59:21  philip
 Moved =cut to end so that ChangeLog can be part of perldoc

 Revision 1.6  2003/03/16 17:52:52  philip
 s/<gt>/E<gt>/g;
 Bug in h2xs generation doc stub

 Revision 1.5  2003/03/16 05:34:47  philip
 Commented out AUTOLOADER since I'm not using it.
 Moved _2 masks before their counter parts.
 Fixe DateTime::Format.

 Revision 1.4  2003/03/15 13:22:16  philip
 Added in leading 0 padding for _2 fields.
 Get rid of conditional creation.

 Revision 1.3  2003/03/15 04:10:04  philip
 Fixed two regex expressions

 Revision 1.2  2003/03/15 03:34:17  philip
 Added /o to regex in elsif

 Revision 1.1.1.1  2003/03/15 03:00:54  philip
 Imported Souces

=cut

