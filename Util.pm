# $Id: Util.pm,v 1.6 2003/03/16 18:03:19 philip Exp $
# $Name:  $

package Date::Util;
use strict;
use warnings FATAL => 'all';
use Carp;

require Exporter;
#use AutoLoader qw(AUTOLOAD);

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
  %months_full
  %r_months_full
  %months_abbrev
  %r_months_abbrev
  %weekdays_full
  %r_weekdays_full
  %weekdays_abbrev
  %r_weekdays_abbrev
  @month_lengths 
  @days
  @months_full
  @weekdays_full
  $regex_month_names
  $regex_day_names
);

our $VERSION = do { my @r = (q$Revision: 1.6 $ =~ /\d+/g); sprintf " %d." . "%02d" x $#r, @r };

our  @months_full   = qw (January February March April May June July August September October November December);
our  @weekdays_full = qw (Sunday Monday Tuesday Wednesday Thursday Friday Saturday);

our %months_full = (
        January   => 1,
        February  => 2,
        March     => 3,
        April     => 4,
        May       => 5,
        June      => 6,
        July      => 7,
        August    => 8,
        September => 9,
        October   => 10,
        November  => 11,
        December  => 12
);
our %r_months_full = reverse %months_full;

our %months_abbrev = (
        Jan => 1,
        Feb => 2,
        Mar => 3,
        Apr => 4,
        May => 5,
        Jun => 6,
        Jul => 7,
        Aug => 8,
        Sep => 9,
        Oct => 10,
        Nov => 11,
        Dec => 12
);
our %r_months_abbrev = reverse %months_abbrev;

our %weekdays_full = (
        Sunday    => 0,
        Monday    => 1,
        Tuesday   => 2,
        Wednesday => 3,
        Thursday  => 4,
        Friday    => 5,
        Saturday  => 6
);
our %r_weekdays_full = reverse %weekdays_full;

our %weekdays_abbrev = (
        Sun    => 0,
        Mon    => 1,
        Tue    => 2,
        Tues   => 2,
        Wed    => 3,
        Wednes => 3,
        Thur   => 4,
        Thurs  => 4,
        Fri    => 5,
        Sat    => 6
);
our %r_weekdays_abbrev = reverse %weekdays_abbrev;


our @month_lengths = (0,31,28,31,30,31,30,31,31,30,31,30,31);

our @days = (1..31);

our $regex_month_names = join ('|', keys %months_full);
our $regex_day_names   = join ('|', keys %weekdays_full);

1;
__END__
=head1 NAME

Date::Util - Things used across Date:: Modules

=head1 SYNOPSIS

  Don't use this yourself

=head2 EXPORT
   
=head1 AUTHOR

Philip M. Gollucci, E<lt>philip@p6m7g8.comE<gt>   

=head1 COPYRIGHT AND LICENSE   

Copyright 2003 by Philip M. Gollucci
   
This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 ChangeLog

 $Log: Util.pm,v $
 Revision 1.6  2003/03/16 18:03:19  philip
 Removed # from ChangeLog sections in perldocumation so it formats correctly

 Revision 1.5  2003/03/16 17:59:22  philip
 Moved =cut to end so that ChangeLog can be part of perldoc

 Revision 1.4  2003/03/16 17:52:52  philip
 s/<gt>/E<gt>/g;
 Bug in h2xs generation doc stub

 Revision 1.3  2003/03/16 16:39:18  philip
 Added arrays for months, weekdays

 Revision 1.2  2003/03/16 05:34:47  philip
 Commented out AUTOLOADER since I'm not using it.
 Moved _2 masks before their counter parts.
 Fixe DateTime::Format.

 Revision 1.1.1.1  2003/03/15 03:00:54  philip
 Imported Souces

=cut
