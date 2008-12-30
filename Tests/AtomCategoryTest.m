#import "AtomCategoryTest.h"
#import "AtomNamespace.h"
#import "AtomCategory.h"

@implementation AtomCategoryTest

- (void)testElement {
  AtomCategory *cat = [ [ AtomCategory alloc ] init ];
  NSString *catString = [ cat stringValue ];
  STAssertEqualObjects( catString, @"<category xmlns=\"http://www.w3.org/2005/Atom\"></category>", nil );
  [ cat release ];
}

- (void)testParams {
  AtomCategory *cat = [ AtomCategory category ];
  [ cat setTerm:@"foo" ]; 
  [ cat setLabel:@"bar" ];
  [ cat setScheme:@"buz" ];
  NSString *catString = [ cat stringValue ];
  STAssertEqualObjects( catString, @"<category xmlns=\"http://www.w3.org/2005/Atom\" term=\"foo\" label=\"bar\" scheme=\"buz\"></category>", nil );
  NSString *term = [ cat term ];
  STAssertEqualObjects( term, @"foo", nil );
  NSString *label = [ cat label ];
  STAssertEqualObjects( label, @"bar", nil );
  NSString *scheme = [ cat scheme ];
  STAssertEqualObjects( scheme, @"buz", nil );
}
@end
