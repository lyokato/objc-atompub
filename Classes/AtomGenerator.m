#import "AtomGenerator.h"
#import "AtomNamespace.h"

@implementation AtomGenerator

//@dynamic name, version, url;
+ (NSString *)elementName {
  return @"generator";
}

+ (NSXMLNode *)elementNamespace {
  return [ AtomNamespace atom ];
}

+ (AtomGenerator *)generator {
  return [ [ [ AtomGenerator alloc ] init ] autorelease ];
}

+ (AtomGenerator *)generatorWithXMLElement:(NSXMLElement *)elem {
  return [ [ [ AtomGenerator alloc ] initWithXMLElement:elem ] autorelease ];
}

+ (AtomGenerator *)generatorWithXMLString:(NSString *)string {
  return [ [ [ AtomGenerator alloc ] initWithXMLString:string ] autorelease ];
}

- (NSString *)name {
  return [ self getElementTextStringWithNamespace:[ AtomNamespace atom ]
                                      elementName:@"name" ];
}

- (void)setName:(NSString *)name {
  [ self setElementWithNamespace:[ AtomNamespace atom ]
                     elementName:@"name"
                           value:name ];
}

- (NSString *)version {
  return [ self getAttributeValueForKey:@"version" ];
}

- (void)setVersion:(NSString *)version {
  [ self setAttributeValue:version
                    forKey:@"version" ];
}

- (NSURL *)url {
  NSString *url = [ self getAttributeValueForKey:@"url" ];
  return (url == nil) ? nil : [ NSURL URLWithString:url ];
}

- (void)setUrl:(NSURL *)url {
  [ self setAttributeValue:[ url absoluteString ]
                    forKey:@"url" ];
}

@end
