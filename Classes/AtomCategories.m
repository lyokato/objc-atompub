#import "AtomCategories.h"
#import "AtomNamespace.h"
#import "AtomCategory.h"

@implementation AtomCategories

// @dynamic category, scheme, href, fixed;

+ (NSString *)elementName {
  return @"categories";
}

+ (NSXMLNode *)elementNamespace {
  return [ AtomNamespace app ];
}

+ (AtomCategories *)categories {
  return [ [ [ AtomCategories alloc ] init ] autorelease ];
}

+ (AtomCategories *)categoriesWithXMLElement:(NSXMLElement *)elem {
  return [ [ [ AtomCategories alloc ] initWithXMLElement:elem ] autorelease ];
}

+ (AtomCategories *)categoriesWithXMLString:(NSString *)string {
  return [ [ [ AtomCategories alloc ] initWithXMLString:string ] autorelease ];
}

- (AtomCategory *)category {
  return [ self getObjectWithNamespace:[ AtomNamespace atom ]
                           elementName:@"category"
                                 class:[ AtomCategory class ]
                           initializer:@selector(categoryWithXMLElement:) ];
}

- (NSArray *)categories {
  return [ self getObjectsWithNamespace:[ AtomNamespace atom ]
                            elementName:@"category"
                                  class:[ AtomCategory class ]
                            initializer:@selector(categoryWithXMLElement:) ];
}

- (void)setCategory:(AtomCategory *)cat {
  [ self setElementWithNamespace:[ AtomNamespace atom ]
                     elementName:@"category"
                     atomElement:cat ];
}

- (void)addCategory:(AtomCategory *)cat {
  [ self addElementWithNamespace:[ AtomNamespace atomWithPrefix ]
                     elementName:@"category"
                     atomElement:cat ];
}

- (NSString *)scheme {
  return [ self getAttributeValueForKey:@"scheme" ];
}

- (void)setScheme:(NSString *)scheme {
  [ self setAttributeValue:scheme
                    forKey:@"scheme" ];
}

- (NSURL *)href {
  NSString *url = [ self getAttributeValueForKey:@"href" ];
  if (url == nil)
    return nil;
  return [ NSURL URLWithString:url ];
}

- (void)setHref:(NSURL *)url {
  [ self setAttributeValue:[ url absoluteString ]
                    forKey:@"href" ];
}

- (BOOL)fixed {
  NSString *isFixed = [ self getAttributeValueForKey:@"fixed" ];
  if (isFixed == nil)
    return NO;
  return ([ isFixed isEqualToString:@"yes" ]) ? YES : NO;
}

- (void)setFixed:(BOOL)fixed {
  NSString *isFixed = (fixed == YES) ? @"yes" : @"no";
  [ self setAttributeValue:isFixed
                    forKey:@"fixed" ];
}

@end
