# $Id: Current.pm,v 1.5 2003/03/16 18:03:19 philip Exp $
# $Name:  $

package Date::Current;
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
  date_get
);

our $VERSION = do { my @r = (q$Revision: 1.5 $ =~ /\d+/g); sprintf " %d." . "%02d" x $#r, @r };

sub date_get {

  my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
  $mon  += 1;
  $year += 1900;

  if (wantarray) {
    return ($year, $mon, $mday, $wday);
  }
  else {
    return "$year $mon $mday $wday";
  }
}

1;
__END__
=head1 NAME
    
Date::Current - Current Date
    
=head1 SYNOPSIS   
    
  use Date::Current;
  my ($year, $mon, $mday, $wday, $yday) = &date_get();
  my $now_string = &date_get();
  
=head2 EXPORT
  date_get();

=head1 AUTHOR

Philip M. Gollucci, E<lt>philip@p6m7g8.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by Philip M. Gollucci

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 ChangeLog

 $Log: Current.pm,v $
 Revision 1.5  2003/03/16 18:03:19  philip
 Removed # from ChangeLog sections in perldocumation so it formats correctly

 Revision 1.4  2003/03/16 17:59:21  philip
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
