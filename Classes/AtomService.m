#import "AtomService.h"
#import "AtomNamespace.h"
#import "AtomWorkspace.h"

@implementation AtomService

+ (NSString *)elementName {
  return @"service";
}

+ (NSXMLNode *)elementNamespace {
  return [ AtomNamespace app ];
}

+ (AtomService *)service {
  return [ [ [ AtomService alloc ] init ] autorelease ];
}

+ (AtomService *)serviceWithXMLElement:(NSXMLElement *)elem {
  return [ [ [ AtomService alloc ] initWithXMLElement:elem ] autorelease ];
}

+ (AtomService *)serviceWithXMLString:(NSString *)string {
  return [ [ [ AtomService alloc ] initWithXMLString:string ] autorelease ];
}

- (AtomWorkspace *)workspace {
  return [ self getObjectWithNamespace:[ AtomNamespace app ]
                           elementName:@"workspace"
                                 class:[ AtomWorkspace class ]
                           initializer:@selector(workspaceWithXMLElement:) ];
}

- (NSArray *)workspaces {
  return [ self getObjectsWithNamespace:[ AtomNamespace app ]
                            elementName:@"workspace"
                                  class:[ AtomWorkspace class ]
                            initializer:@selector(workspaceWithXMLElement:) ];
}

- (void)setWorkspace:(AtomWorkspace *)workspace {
  [ self setElementWithNamespace:[ AtomNamespace app ]
                     elementName:@"workspace"
                     atomElement:workspace ];
}

- (void)addWorkspace:(AtomWorkspace *)workspace {
  [ self addElementWithNamespace:[ AtomNamespace app ]
                     elementName:@"workspace"
                     atomElement:workspace ];
}

@end

