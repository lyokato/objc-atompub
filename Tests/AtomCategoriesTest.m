#import "AtomCategoriesTest.h"
#import "AtomCategories.h"
#import "AtomCategory.h"

@implementation AtomCategoriesTest

- (void)testElement {
  AtomCategories *cats = [ [ AtomCategories alloc ] init ];
  NSString *catsString = [ cats stringValue ];
  STAssertEqualObjects( catsString, @"<categories xmlns=\"http://www.w3.org/2007/app\"></categories>", nil );
  [ cats release ];
}

- (void)testParams {
  AtomCategories *cats = [ AtomCategories categories ];
  [ cats setFixed:YES ];
  [ cats setHref:[ NSURL URLWithString:@"http://example.org/" ] ];
  [ cats setScheme:@"foobar" ];
  AtomCategory *cat = [ AtomCategory category ];
  [ cat setTerm:@"foo" ]; 
  [ cat setLabel:@"bar" ];
  [ cat setScheme:@"buz" ];
  [ cats addCategory:cat ];
  NSString *catsString = [ cats stringValue ];
  STAssertEqualObjects( catsString, @"<categories xmlns=\"http://www.w3.org/2007/app\" fixed=\"yes\" href=\"http://example.org/\" scheme=\"foobar\"><category xmlns:atom=\"http://www.w3.org/2005/Atom\" term=\"foo\" label=\"bar\" scheme=\"buz\"></category></categories>", nil );
}

@end
