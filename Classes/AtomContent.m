#import "AtomContent.h"
#import "AtomNamespace.h"

@implementation AtomContent

+ (NSString *)elementName {
  return @"content";
}

+ (NSXMLNode *)elementNamespace {
  return [ AtomNamespace atom ];
}

- (NSString *)type {
  return [ self getAttributeValueForKey:@"type" ];
}

- (void)setType:(NSString *)aType {
  [ self setAttributeValue:aType
                    forKey:@"type" ];
}

- (NSURL *)src {
  NSString *s = [ self getAttributeValueForKey:@"src" ];
  return (s != nil) ? [ NSURL URLWithString:s ] : nil;
}

- (void)setSrc:(NSURL *)aSrc {
  [ self setAttributeValue:[ aSrc absoluteString ]
                    forKey:@"src" ];
}

- (NSString *)body {
  return [ [ self element ] stringValue ];
}

- (void)setBodyWithString:(NSString *)aBody {
  NSString *div = [ NSString stringWithFormat:@"<div xmlns=\"http://www.w3.org/1999/xhtml\">%@</div>", aBody ];
  BOOL isValid = YES;
  NSXMLElement *bodyElement =
    [ [ NSXMLElement alloc ] initWithXMLString:div
                                         error:nil ];
  NSXMLNode *node, *child;
  if (bodyElement != nil) {
    int count = [ bodyElement childCount ];
    int i;
    for (i = 0; i < count; i++) {
      child = [ bodyElement childAtIndex:i ];
      if ([ child kind ] == NSXMLElementKind) {
        node = child;
        break;
      }
    }
  } else {
    isValid = NO;
  }

  if (isValid && node != nil) {
    [ [ self element ] addChild:node ];
    [ self setType:@"xhtml" ];
  } else {
    [ [ self element ] addChild:[ NSXMLNode textWithStringValue:aBody ] ];
    [ self setType:@"text" ];
    // check start tag
  }
}

- (void)setBodyWithXMLElement:(NSXMLElement *)aBody {
  [ [ self element ] addChild:aBody ];
  [ self setType:@"xhtml" ];
}

@end
