# $Id: Weekday.pm,v 1.5 2003/03/16 18:03:19 philip Exp $
# $Name:  $

package Date::Weekday;
use strict;
use warnings FATAL => 'all';
use Carp;

use Date::Util;

require Exporter;
#use AutoLoader qw(AUTOLOAD);

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
);

our $VERSION = do { my @r = (q$Revision: 1.5 $ =~ /\d+/g); sprintf " %d." . "%02d" x $#r, @r };

sub date_weekday_get ($$$) {

  my ($year, $month, $mday) = @_;

  my $fyear  = &year_first_get($year);
  my $fmonth = &month_first_get($fyear, $month);

  my $weekday = &weekday_calculate($fmonth, $mday);
 
  return $weekday;
}

sub weekday_calculate ($$) {

  my ($fmonth, $mday) = @_;
  my $start = 1;
  my $end   = $mday;

  while ($start <= $mday)  {
    $fmonth++;
    $fmonth = 0 if $fmonth > 6;
    $start++;
  }
 
  return $fmonth -1;
}

sub year_first_get ($) {

 my ($year) = @_;

 my $start_year = 2001;
 my $numleapyears = 0;

 for (my $index = $start_year; $index < $year; $index++) {
   $numleapyears += &year_leapyear_is($index);
 }

 my $fyear = (($year - $start_year) + $numleapyears + 1) % 7;

 return $fyear;
}

sub month_first_get ($$) {

  my ($fyear, $month) = @_;
  my $day;
  my $offset;

  $offset = 0  if $month == 1;
  $offset = 3  if $month == 2;
  $offset = 3  if $month == 3;
  $offset = -1 if $month == 4;
  $offset = 1  if $month == 5;
  $offset = 4  if $month == 6;
  $offset = -1 if $month == 7;
  $offset = 2  if $month == 8;
  $offset = 5  if $month == 9;
  $offset = 0  if $month == 10;
  $offset = 3  if $month == 11;
  $offset = 5  if $month == 12;

  $day = $fyear;
  $day += $offset;
    
  $day = $day % 7 if ($day > 6);

  return $day;
}

sub month_length_get ($$) {
  
  my ($month, $year) = @_;

  if ($month == 2 && &year_leapyear_is($year)) {return 29;}
  else {return $month_lengths[$month];}
}

sub year_leapyear_is ($) {

  my ($year) = @_;

  if ((($year % 4 == 0) && ($year % 100 != 0)) || ($year % 400 == 0)) {return 1;}
  else {return 0;}
}

1;
__END__
=head1 NAME
    
Date::Weekday - Get the weekday based on year month and mday
    
=head1 SYNOPSIS   
    
  Don't use this, use Date::Format instead
 
=head2 EXPORT
  date_weekday_get

=head1 AUTHOR

Philip M. Gollucci, E<lt>philip@p6m7g8.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by Philip M. Gollucci

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 ChangeLog

 $Log: Weekday.pm,v $
 Revision 1.5  2003/03/16 18:03:19  philip
 Removed # from ChangeLog sections in perldocumation so it formats correctly

 Revision 1.4  2003/03/16 17:59:22  philip
 Moved =cut to end so that ChangeLog can be part of perldoc

 Revision 1.3  2003/03/16 17:52:52  philip
 s/<gt>/E<gt>/g;
 Bug in h2xs generation doc stub

 Revision 1.2  2003/03/16 05:34:47  philip
 Commented out AUTOLOADER since I'm not using it.
 Moved _2 masks before their counter parts.
 Fixe DateTime::Format.

 Revision 1.1.1.1  2003/03/15 03:00:54  philip
 Imported Souces

=cut
