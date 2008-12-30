#import "AtomCategory.h"
#import "AtomNamespace.h"

@implementation AtomCategory

// @dynamic term, label, scheme;
+ (NSString *)elementName {
  return @"category";
}

+ (NSXMLNode *)elementNamespace {
  return [ AtomNamespace atom ];
}

+ (AtomCategory *)category {
  return [ [ [ AtomCategory alloc ] init ] autorelease ];
}

+ (AtomCategory *)categoryWithXMLElement:(NSXMLElement *)elem {
  return [ [ [ AtomCategory alloc ] initWithXMLElement:elem ] autorelease ];
}

+ (AtomCategory *)categoryWithXMLString:(NSString *)string {
  return [ [ [ AtomCategory alloc ] initWithXMLString:string ] autorelease ];
}

- (NSString *)term {
  return [ self getAttributeValueForKey:@"term" ];
}

- (void)setTerm:(NSString *)term {
  [ self setAttributeValue:term
                    forKey:@"term" ];
}

- (NSString *)label {
  return [ self getAttributeValueForKey:@"label" ];
}

- (void)setLabel:(NSString *)label {
  [ self setAttributeValue:label
                    forKey:@"label" ];
}

- (NSString *)scheme {
  return [ self getAttributeValueForKey:@"scheme" ];
}

- (void)setScheme:(NSString *)scheme {
  [ self setAttributeValue:scheme
                    forKey:@"scheme" ];
}

@end
