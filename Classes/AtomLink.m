#import "AtomLink.h";
#import "AtomNamespace.h";

@implementation AtomLink

// @dynamic rel, type, hreflang, title, length, href;
+ (NSString *)elementName {
  return @"link"; 
}

+ (NSXMLNode *)elementNamespace {
  return [ AtomNamespace atom ];
}

+ (AtomLink *)link {
  return [ [ [ AtomLink alloc ] init ] autorelease ];
}

+ (AtomLink *)linkWithXMLElement:(NSXMLElement *)elem {
  return [ [ [ AtomLink alloc ] initWithXMLElement:elem ] autorelease ];
}

+ (AtomLink *)linkWithXMLString:(NSString *)string {
  return [ [ [ AtomLink alloc ] initWithString:string ] autorelease ];
}

- (NSURL *)href {
  NSString *url = [ self getAttributeValueForKey:@"href" ];
  return (url != nil) ? [ NSURL URLWithString:url ] : nil;
}

- (void)setHref:(NSURL *)url {
  [ self setAttributeValue:[ url absoluteString ]
                    forKey:@"href" ];
}

- (NSString *)rel {
  return [ self getAttributeValueForKey:@"rel" ];
}

- (void)setRel:(NSString *)rel {
  [ self setAttributeValue:rel
                    forKey:@"rel" ];
}

- (NSString *)type {
  return [ self getAttributeValueForKey:@"type" ];
}

- (void)setType:(NSString *)type {
  [ self setAttributeValue:type
                    forKey:@"type" ];
}

- (NSString *)hreflang {
  return [ self getAttributeValueForKey:@"hreflang" ];
}

- (void)setHreflang:(NSString *)hreflang {
  [ self setAttributeValue:hreflang
                    forKey:@"hreflang" ];
}

- (NSString *)title {
  return [ self getAttributeValueForKey:@"title" ];
}

- (void)setTitle:(NSString *)title {
  [ self setAttributeValue:title
                    forKey:@"title" ];
}

- (int)length {
  NSString *length = [ self getAttributeValueForKey:@"length" ];
  return (length != nil) ? [ length intValue ] : nil;
}

- (void)setLength:(int)length {
  [ self setAttributeValue:[ [ NSNumber numberWithInt:length ] stringValue ]
                    forKey:@"length" ];
}

@end

