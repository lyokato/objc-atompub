#import "AtomCollectionTest.h"
#import "AtomCollection.h"
#import "AtomCategory.h"
#import "AtomCategories.h"

@implementation AtomCollectionTest

- (void)testElement {
  AtomCollection *coll = [ [ AtomCollection alloc ] init ];
  NSString *collString = [ coll stringValue ];
  STAssertEqualObjects( collString, @"<collection xmlns=\"http://www.w3.org/2007/app\"></collection>", nil );
  [ coll release ];
}

- (void)testParams {
  AtomCollection *coll = [ AtomCollection collection ];
  [ coll setTitle:@"mytitle" ];
  [ coll setHref:[ NSURL URLWithString:@"http://example.org/" ] ];
  [ coll addAccept:@"image/jpeg" ];
  [ coll addAccept:@"image/png" ];
  AtomCategories *cats = [ AtomCategories categories ];
  [ cats setFixed:YES ];
  [ cats setHref:[ NSURL URLWithString:@"http://example.org/" ] ];
  [ cats setScheme:@"foobar" ];
  AtomCategory *cat = [ AtomCategory category ];
  [ cat setTerm:@"foo" ]; 
  [ cat setLabel:@"bar" ];
  [ cat setScheme:@"buz" ];
  [ cats addCategory:cat ];
  [ coll setCategories:cats ];
  NSString *collString = [ coll stringValue ];
  STAssertEqualObjects( collString, @"<collection xmlns=\"http://www.w3.org/2007/app\" href=\"http://example.org/\"><title xmlns=\"http://www.w3.org/2005/Atom\">mytitle</title><accept xmlns=\"http://www.w3.org/2007/app\">image/jpeg</accept><accept xmlns=\"http://www.w3.org/2007/app\">image/png</accept><categories xmlns=\"http://www.w3.org/2007/app\" fixed=\"yes\" href=\"http://example.org/\" scheme=\"foobar\"><category xmlns:atom=\"http://www.w3.org/2005/Atom\" term=\"foo\" label=\"bar\" scheme=\"buz\"></category></categories></collection>", nil );
}


@end
