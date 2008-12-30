#import "AtomLinkTest.h"
#import "AtomLink.h"
#import "AtomNamespace.h"

@implementation AtomLinkTest

- (void)testElement {
  AtomLink *link = [ [ AtomLink alloc ] init ];
  NSString *linkString = [ link stringValue ];
  STAssertEqualObjects( linkString, @"<link xmlns=\"http://www.w3.org/2005/Atom\"></link>", nil );
  [ link release ];
}

- (void)testParams {
  AtomLink *link = [ [ AtomLink alloc ] init ];
  [ link setRel:@"alternate" ];
  [ link setHref:[ NSURL URLWithString:@"http://example.org/related" ] ];
  NSString *linkString = [ link stringValue ];
  STAssertEqualObjects( linkString, @"<link xmlns=\"http://www.w3.org/2005/Atom\" rel=\"alternate\" href=\"http://example.org/related\"></link>", nil );
  [ link setTitle:@"hogehoge" ];
  [ link setHreflang:@"en-us" ];
  NSString *linkString2 = [ link stringValue ];
  STAssertEqualObjects( linkString2, @"<link xmlns=\"http://www.w3.org/2005/Atom\" rel=\"alternate\" href=\"http://example.org/related\" title=\"hogehoge\" hreflang=\"en-us\"></link>", nil );
  NSString *rel = [ link rel ];
  STAssertEqualObjects( rel, @"alternate", nil );
  NSURL *href = [ link href ];
  STAssertEqualObjects( [ href absoluteString ], @"http://example.org/related", nil );
  NSString *title = [ link title ];
  STAssertEqualObjects( title, @"hogehoge", nil );
  NSString *lang = [ link hreflang ];
  STAssertEqualObjects( lang, @"en-us", nil );

  [ link setLength:20 ];
  NSString *linkString3 = [ link stringValue ];
  STAssertEqualObjects( linkString3, @"<link xmlns=\"http://www.w3.org/2005/Atom\" rel=\"alternate\" href=\"http://example.org/related\" title=\"hogehoge\" hreflang=\"en-us\" length=\"20\"></link>", nil );
  int len = [ link length ];
  STAssertEquals( (float)len, 20.0f, nil );
  [ link release ];
}

- (void)testInsertion {
  AtomElement *elem = [ [ AtomElement alloc ] init ];
  AtomLink *link = [ [ AtomLink alloc ] init ];
  [ link setRel:@"alternate" ];
  [ link setHref:[ NSURL URLWithString:@"http://example.org/related" ] ];
  [ elem addElementWithNamespace:[ AtomNamespace atom ]
                     elementName:@"link"
                     atomElement:link ];
  NSString *result = [ elem stringValue ];
  STAssertEqualObjects( result, @"<element xmlns=\"http://www.w3.org/2005/Atom\"><link xmlns=\"http://www.w3.org/2005/Atom\" rel=\"alternate\" href=\"http://example.org/related\"></link></element>", nil );
  [ elem release ];
}

- (void)testParsing {
  AtomLink *link = [ [ AtomLink alloc ] initWithXMLString:@"<link xmlns=\"http://www.w3.org/2005/Atom\" rel=\"related\" href=\"http://example.org/related\"/>" ];
  NSString *rel  = [ link rel ];
  NSURL *href = [ link href ];
  STAssertEqualObjects( rel, @"related", nil );
  STAssertEqualObjects( [ href absoluteString ], @"http://example.org/related", nil );
}

@end
