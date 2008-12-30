#import "AtomServiceTest.h"
#import "AtomService.h"
#import "AtomWorkspace.h"
#import "AtomCollection.h"
#import "AtomCategories.h"
#import "AtomCategory.h"

@implementation AtomServiceTest

- (void)testParams {
  AtomService *s = [ AtomService service ];
  AtomWorkspace *w = [ AtomWorkspace workspace ];
  [ w setTitle:@"workspacetitle" ];
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
  [ w addCollection:coll ];
  [ s addWorkspace:w ];
  NSString *ss = [ s stringValue ];
  STAssertEqualObjects( ss, @"<service xmlns=\"http://www.w3.org/2007/app\"><workspace xmlns=\"http://www.w3.org/2007/app\"><title xmlns=\"http://www.w3.org/2005/Atom\">workspacetitle</title><collection xmlns=\"http://www.w3.org/2007/app\" href=\"http://example.org/\"><title xmlns=\"http://www.w3.org/2005/Atom\">mytitle</title><accept xmlns=\"http://www.w3.org/2007/app\">image/jpeg</accept><accept xmlns=\"http://www.w3.org/2007/app\">image/png</accept><categories xmlns=\"http://www.w3.org/2007/app\" fixed=\"yes\" href=\"http://example.org/\" scheme=\"foobar\"><category xmlns:atom=\"http://www.w3.org/2005/Atom\" term=\"foo\" label=\"bar\" scheme=\"buz\"></category></categories></collection></workspace></service>", nil );
}

- (void)testParse {
  NSString *src = @"<service xmlns=\"http://www.w3.org/2007/app\"><workspace xmlns=\"http://www.w3.org/2007/app\"><title xmlns=\"http://www.w3.org/2005/Atom\">workspacetitle</title><collection xmlns=\"http://www.w3.org/2007/app\" href=\"http://example.org/\"><title xmlns=\"http://www.w3.org/2005/Atom\">mytitle</title><accept xmlns=\"http://www.w3.org/2007/app\">image/jpeg</accept><accept xmlns=\"http://www.w3.org/2007/app\">image/png</accept><categories xmlns=\"http://www.w3.org/2007/app\" fixed=\"yes\" href=\"http://example.org/\" scheme=\"foobar\"><category xmlns=\"http://www.w3.org/2005/Atom\" term=\"foo\" label=\"bar\" scheme=\"buz\"></category></categories></collection></workspace></service>";
  AtomService *s = [ AtomService serviceWithXMLString:src ];
  AtomWorkspace *w = [ s workspace ];
  STAssertNotNil(w, nil);
  NSString *wTitle = [ w title ];
  STAssertEqualObjects(wTitle, @"workspacetitle", nil);
  AtomCollection *coll = [ w collection ];
  STAssertEqualObjects([ coll title ], @"mytitle", nil );
  STAssertEqualObjects([ [ coll href ] absoluteString ], @"http://example.org/", nil );
  AtomCategories *cats = [ coll categories ];
  NSArray *categories = [ cats categories ];
  int count = [ categories count ];
  STAssertEquals((double)count, 1.0, nil );
  AtomCategory *cat = [ categories objectAtIndex:0 ];
  NSString *catString = [ cat stringValue ];
  STAssertEqualObjects( catString, @"<category xmlns=\"http://www.w3.org/2005/Atom\" term=\"foo\" label=\"bar\" scheme=\"buz\"></category>", nil );
}

@end
