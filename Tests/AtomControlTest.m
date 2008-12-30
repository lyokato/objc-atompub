#import "AtomControlTest.h"
#import "AtomControl.h"
#import "AtomNamespace.h"

@implementation AtomControlTest
- (void)testElement {
  AtomControl *control = [ [ AtomControl alloc ] init ];
  NSString *controlString = [ control stringValue ];
  STAssertEqualObjects( controlString, @"<control xmlns=\"http://www.w3.org/2007/app\"></control>", nil );
  [ control release ];
}
- (void)testParams {
  AtomControl *control = [ [ AtomControl alloc ] init ];
  [ control setDraft:YES ];
  NSString *controlString = [ control stringValue ];
  STAssertEqualObjects( controlString, @"<control xmlns=\"http://www.w3.org/2007/app\"><draft xmlns=\"http://www.w3.org/2007/app\">yes</draft></control>", nil );
  BOOL isDraft = [ control draft ];
  STAssertTrue(isDraft, nil);
  [ control release ];
}
- (void)testInsertion {
  AtomElement *elem = [ [ AtomElement alloc ] init ];
  AtomControl *control = [ [ AtomControl alloc ] init ];
  [ control setDraft:YES ];
  [ elem addElementWithNamespace:[ AtomNamespace app ]
                     elementName:@"control"
                     atomElement:control ];
  NSString *result = [ elem stringValue ];
  STAssertEqualObjects( result, @"<element xmlns=\"http://www.w3.org/2005/Atom\"><control xmlns=\"http://www.w3.org/2007/app\"><draft xmlns=\"http://www.w3.org/2007/app\">yes</draft></control></element>", nil );
  [ elem release ];
}
@end
