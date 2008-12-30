#import "AtomPerson.h"
#import "AtomNamespace.h"

@implementation AtomPerson

// @dynamic email, name, uri;
+ (NSString *)elementName {
  return @"author";
}

+ (NSXMLNode *)elementNamespace {
  return [ AtomNamespace atom ];
}

+ (AtomPerson *)person {
  return [ [ [ AtomPerson alloc ] init ] autorelease ];
}

+ (AtomPerson *)personWithXMLElement:(NSXMLElement *)elem {
  return [ [ [ AtomPerson alloc ] initWithXMLElement:elem ] autorelease ];
}

+ (AtomPerson *)personWithXMLString:(NSString *)string {
  return [ [ [ AtomPerson alloc ] initWithXMLString:string ] autorelease ];
}

- (NSString *)email {
  return [ self getElementTextStringWithNamespace:[ [ self class ] elementNamespace ]
                                      elementName:@"email" ];
}

- (void)setEmail:(NSString *)email {
  [ self setElementWithNamespace:[ [ self class ] elementNamespace ]
                     elementName:@"email"
                           value:email ];
}

- (NSURL *)uri {
  NSString *u = [ self getElementTextStringWithNamespace:[ [ self class ] elementNamespace ]
                                             elementName:@"uri" ];
  return (u != nil) ? [ NSURL URLWithString:u ] : nil;
}

- (void)setUri:(NSURL *)uri {
  [ self setElementWithNamespace:[ [ self class ] elementNamespace ]
                     elementName:@"uri"
                           value:[ uri absoluteString ] ];
}

- (NSString *)name {
  return [ self getElementTextStringWithNamespace:[ [ self class ] elementNamespace ]
                                      elementName:@"name" ];
}

- (void)setName:(NSString *)name {
  [ self setElementWithNamespace:[ [ self class ] elementNamespace ]
                     elementName:@"name"
                           value:name ];
}

@end

