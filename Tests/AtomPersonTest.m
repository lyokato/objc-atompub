#import "AtomPersonTest.h"
#import "AtomPerson.h"
#import "AtomNamespace.h"

@implementation AtomPersonTest
- (void)testElement {
  AtomPerson *person = [ [ AtomPerson alloc ] init ];
  NSString *personString = [ person stringValue ];
  STAssertEqualObjects( personString, @"<author xmlns=\"http://www.w3.org/2005/Atom\"></author>", nil );
  [ person release ];
}

- (void)testParams {
  AtomPerson *person = [ [ AtomPerson alloc ] init ];
  [ person setName:@"Foo Bar" ];
  [ person setUri:[NSURL URLWithString:@"http://example.org/" ] ];
  [ person setEmail:@"sample@example.org" ];
  NSString *personString = [ person stringValue ];
  STAssertEqualObjects( personString, @"<author xmlns=\"http://www.w3.org/2005/Atom\"><name xmlns=\"http://www.w3.org/2005/Atom\">Foo Bar</name><uri xmlns=\"http://www.w3.org/2005/Atom\">http://example.org/</uri><email xmlns=\"http://www.w3.org/2005/Atom\">sample@example.org</email></author>", nil );
  NSString *name  = [ person name ];
  NSString *email = [ person email ];
  NSURL    *uri   = [ person uri ];
  STAssertEqualObjects( name,  @"Foo Bar", nil );
  STAssertEqualObjects( email, @"sample@example.org", nil );
  STAssertEqualObjects( [ uri absoluteString ], @"http://example.org/", nil );
  [ person release ];
}

- (void)testInsertion {
  AtomElement *elem = [ [ AtomElement alloc ] init ];
  AtomPerson *author = [ [ AtomPerson alloc ] init ];
  [ author setName:@"Foo" ];
  AtomPerson *cont = [ [ AtomPerson alloc ] init ];
  [ cont setName:@"Bar" ];
  [ elem addElementWithNamespace:[ AtomNamespace atom ]
                     elementName:@"author"
                     atomElement:author ];
  [ elem addElementWithNamespace:[ AtomNamespace atom ]
                     elementName:@"contributor"
                     atomElement:cont ];
  NSString *result = [ elem stringValue ];
  STAssertEqualObjects( result, @"<element xmlns=\"http://www.w3.org/2005/Atom\"><author xmlns=\"http://www.w3.org/2005/Atom\"><name xmlns=\"http://www.w3.org/2005/Atom\">Foo</name></author><contributor xmlns=\"http://www.w3.org/2005/Atom\"><name xmlns=\"http://www.w3.org/2005/Atom\">Bar</name></contributor></element>", nil);
  [ elem release ];
}

@end
