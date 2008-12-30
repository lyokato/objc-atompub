#import "AtomWorkspace.h"
#import "AtomNamespace.h"
#import "AtomCollection.h"

@implementation AtomWorkspace

// @dynamic title, collection;

+ (NSString *)elementName {
  return @"workspace";
}

+ (NSXMLNode *)elementNamespace {
  return [ AtomNamespace app ];
}

+ (AtomWorkspace *)workspace {
  return [ [ [ AtomWorkspace alloc ] init ] autorelease ];
}

+ (AtomWorkspace *)workspaceWithXMLElement:(NSXMLElement *)elem {
  return [ [ [ AtomWorkspace alloc ] initWithXMLElement:elem ] autorelease ];
}

+ (AtomWorkspace *)workspaceWithXMLString:(NSString *)string {
  return [ [ [ AtomWorkspace alloc ] initWithXMLString:string ] autorelease ];
}

- (NSString *)title {
  return [ self getElementTextStringWithNamespace:[ AtomNamespace atom ]
                                      elementName:@"title" ];
}

- (void)setTitle:(NSString *)title {
  [ self setElementWithNamespace:[ AtomNamespace atom ]
                     elementName:@"title"
                           value:title ];
}

- (AtomCollection *)collection {
  return [ self getObjectWithNamespace:[ AtomNamespace app ]
                           elementName:@"collection"
                                 class:[ AtomCollection class ]
                           initializer:@selector(collectionWithXMLElement:) ];
}

- (NSArray *)collections {
  return [ self getObjectsWithNamespace:[ AtomNamespace app ]
                            elementName:@"collection"
                                  class:[ AtomCollection class ]
                            initializer:@selector(collectionWithXMLElement:) ];
}

- (void)setCollection:(AtomCollection *)coll {
  [ self setElementWithNamespace:[ AtomNamespace app ]
                     elementName:@"collection"
                     atomElement:coll ];
}

- (void)addCollection:(AtomCollection *)coll {
  [ self addElementWithNamespace:[ AtomNamespace app ]
                     elementName:@"collection"
                     atomElement:coll ];
}


@end

