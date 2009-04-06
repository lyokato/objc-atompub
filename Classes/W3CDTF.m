#import "W3CDTF.h";

@implementation W3CDTF

+ (NSDate *)dateFromString:(NSString *)formattedDate {
  NSRange idx = [ formattedDate rangeOfString:@"T" ];
  if (idx.location == NSNotFound)
    return nil;

  NSString *dateString = [ formattedDate substringToIndex:idx.location ];
  NSString *timeString = [ formattedDate substringFromIndex:idx.location + 1 ];

  NSArray *dateArray = [ dateString componentsSeparatedByString:@"-" ];

  int year  = [ (NSString *)[ dateArray objectAtIndex:0 ] intValue ];
  int month = [ (NSString *)[ dateArray objectAtIndex:1 ] intValue ];
  int date  = [ (NSString *)[ dateArray objectAtIndex:2 ] intValue ];

  int multiplier = 1;
  int offsetHours, offsetMinutes;
  NSString *offsetString, *newTimeString;

  NSRange zRange     = [ timeString rangeOfString:@"Z" ];
  NSRange plusRange  = [ timeString rangeOfString:@"+" ];
  NSRange minusRange = [ timeString rangeOfString:@"-" ];
  NSRange colonRange;

  if ([ timeString hasSuffix:@"Z" ]) {

    offsetHours = 0;
    offsetMinutes = 0;
    newTimeString = [ timeString substringToIndex:zRange.location ];

  } else if (plusRange.location != NSNotFound) {

    offsetString  = [ timeString substringFromIndex:plusRange.location + 1 ];
    colonRange    = [ offsetString rangeOfString:@":" ];
    offsetHours   = [ [ offsetString substringToIndex:colonRange.location ] intValue ];
    offsetMinutes = [ [ offsetString substringFromIndex:colonRange.location + 1 ] intValue ];
    newTimeString = [ timeString substringToIndex:plusRange.location ];

  } else if (minusRange.location != NSNotFound) {

    multiplier = -1;
    offsetString  = [ timeString substringFromIndex:minusRange.location + 1 ];
    colonRange    = [ offsetString rangeOfString:@":" ];
    offsetHours   = [ [ offsetString substringToIndex:colonRange.location ] intValue ];
    offsetMinutes = [ [ offsetString substringFromIndex:colonRange.location + 1 ] intValue ];
    newTimeString = [ timeString substringToIndex:minusRange.location ];

  } else {

    return nil;

  }

  NSArray *timeArray = [ newTimeString componentsSeparatedByString:@":"];
  int hours   = [ (NSString *)[ timeArray objectAtIndex:0 ] intValue ];
  int minutes = [ (NSString *)[ timeArray objectAtIndex:1 ] intValue ];
  int seconds, milliseconds;
  if ( [ timeArray count ] > 3 ) {
    NSString *secondsString = (NSString *)[ timeArray objectAtIndex:2 ];
    NSArray *secondsArray = [ secondsString componentsSeparatedByString:@"." ];
    seconds = [ [ secondsArray objectAtIndex:0 ] intValue ];
    milliseconds = ( [ secondsArray count ] > 2 )
      ? [ (NSString *)[ secondsArray objectAtIndex:1 ] intValue ]
      : 0;
  } else {
    seconds = milliseconds = 0;
  }
#if 1
  NSCalendar *gregorian = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSGregorianCalendar ];
  [ gregorian setTimeZone:[ NSTimeZone timeZoneWithAbbreviation:@"UTC" ] ];

  NSDateComponents *components = [ [ NSDateComponents alloc ] init ];
  [ components setYear:year ];
  [ components setMonth:month ];
  [ components setDay:date ];
  [ components setHour:hours ];
  [ components setMinute:minutes ];
  [ components setSecond:seconds ];

  NSDate *utcDate = [ gregorian dateFromComponents:components ];
  [ components release ];
  [ gregorian release ];
#else
  NSDate *utcDate = [ NSCalendarDate dateWithYear:year
                                            month:month
                                              day:date
                                             hour:hours
                                           minute:minutes
                                           second:seconds
                                         timeZone:[ NSTimeZone timeZoneWithAbbreviation:@"UTC" ] ];
#endif
  int offset = (( offsetHours * 3600 ) + ( offsetMinutes * 60 )) * multiplier;
  NSTimeInterval interval = [ utcDate timeIntervalSinceReferenceDate ] - offset;
  return [ NSDate dateWithTimeIntervalSinceReferenceDate:interval ];
}

+ (NSString *)stringFromDate:(NSDate *)date {
    time_t clock = [date timeIntervalSince1970];

    char str[255];
    strftime(str, sizeof(str), "%Y-%m-%dT%H:%M:%SZ", gmtime(&clock));

    return [NSString stringWithUTF8String: str];
}

@end

