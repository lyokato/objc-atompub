#import "W3CDTFTest.h"
#import "W3CDTF.h"

@implementation W3CDTFTest
- (void)testParsing {
  NSString *pattern1 = @"2008-01-01T04:05:22";
  NSString *pattern2 = @"2008-01-01T04:05:22Z";
  NSString *pattern3 = @"2008-01-01T04:05:22+09:00";
  NSString *pattern4 = @"2008-01-01T04:05:22.00Z";
  NSString *pattern5 = @"2008-01-01T04:05:22.00+09:00";
  NSDate *date1 = [ W3CDTF dateFromString:pattern1 ];
  NSDate *date2 = [ W3CDTF dateFromString:pattern2 ];
  NSDate *date3 = [ W3CDTF dateFromString:pattern3 ];
  NSDate *date4 = [ W3CDTF dateFromString:pattern4 ];
  NSDate *date5 = [ W3CDTF dateFromString:pattern5 ];
  STAssertNil( date1, nil );
  STAssertEqualObjects([ date2 description ], @"2008-01-01 13:05:00 +0900", nil );
  STAssertEqualObjects([ date3 description ], @"2008-01-01 04:05:00 +0900", nil );
  STAssertEqualObjects([ date4 description ], @"2008-01-01 13:05:00 +0900", nil );
  STAssertEqualObjects([ date5 description ], @"2008-01-01 04:05:00 +0900", nil );
}
@end
