#import "AtomWorkspaceTest.h"
#import "AtomWorkspace.h"
#import "AtomCollection.h"
#import "AtomCategories.h"
#import "AtomCategory.h"
#import "AtomNamespace.h"

@implementation AtomWorkspaceTest


- (void)testParams {
  AtomWorkspace *w = [ AtomWorkspace workspace ];
  [ w setTitle:@"workspacetitle" ];
  NSString *title = [ w title ];
  STAssertEqualObjects( title, @"workspacetitle", nil );
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
  NSString *ws = [ w stringValue ];
  STAssertEqualObjects( ws, @"<workspace xmlns=\"http://www.w3.org/2007/app\"><title xmlns=\"http://www.w3.org/2005/Atom\">workspacetitle</title><collection xmlns=\"http://www.w3.org/2007/app\" href=\"http://example.org/\"><title xmlns=\"http://www.w3.org/2005/Atom\">mytitle</title><accept xmlns=\"http://www.w3.org/2007/app\">image/jpeg</accept><accept xmlns=\"http://www.w3.org/2007/app\">image/png</accept><categories xmlns=\"http://www.w3.org/2007/app\" fixed=\"yes\" href=\"http://example.org/\" scheme=\"foobar\"><category xmlns:atom=\"http://www.w3.org/2005/Atom\" term=\"foo\" label=\"bar\" scheme=\"buz\"></category></categories></collection></workspace>", nil );
}


@end
