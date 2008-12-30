#import "AtomCollection.h"
#import "AtomNamespace.h"
#import "AtomCategories.h"

@implementation AtomCollection

// @dynamic title, href, categories, accept;

+ (NSString *)elementName {
  return @"collection";
}

+ (NSXMLNode *)elementNamespace {
  return [ AtomNamespace app ];
}

+ (AtomCollection *)collection {
  return [ [ [ AtomCollection alloc ] init ] autorelease ];
}

+ (AtomCollection *)collectionWithXMLElement:(NSXMLElement *)elem {
  return [ [ [ AtomCollection alloc ] initWithXMLElement:elem ] autorelease ];
}

+ (AtomCollection *)collectionWithXMLString:(NSString *)string {
  return [ [ [ AtomCollection alloc ] initWithXMLString:string ] autorelease ];
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

- (NSURL *)href {
  NSString *url = [ self getAttributeValueForKey:@"href" ];
  return (url == nil) ? nil : [ NSURL URLWithString:url ];
}

- (void)setHref:(NSURL *)url {
  [ self setAttributeValue:[ url absoluteString ]
                    forKey:@"href" ];
}

- (AtomCategories *)categories {
  return [ self getObjectWithNamespace:[ AtomNamespace app ]
                           elementName:@"categories"
                                 class:[ AtomCategories class ]
                           initializer:@selector(categoriesWithXMLElement:) ];
}

- (void)setCategories:(AtomCategories *)cats {
  [ self setElementWithNamespace:[ AtomNamespace app ]
                     elementName:@"categories"
                     atomElement:cats ];
}

- (NSString *)accept {
  return [ self getElementTextStringWithNamespace:[ AtomNamespace app ]
                                      elementName:@"accept" ];
}

- (NSArray *)accepts {
  return [ self getElementsTextStringWithNamespace:[ AtomNamespace app ]
                                       elementName:@"accept" ];
}

- (void)setAccept:(NSString *)accept {
  [ self setElementWithNamespace:[ AtomNamespace app ]
                     elementName:@"accept"
                           value:accept ];
}

- (void)addAccept:(NSString *)accept {
  [ self addElementWithNamespace:[ AtomNamespace app ]
                     elementName:@"accept"
                           value:accept ];
}

@end

