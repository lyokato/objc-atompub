#import "AtomElement.h"
#import "AtomNamespace.h"

@implementation AtomElement

+ (NSString *)elementName {
  return @"element";
}

+ (NSXMLNode *)elementNamespace {
  return [ AtomNamespace atom ];
}

- (id)init {
  if ((self = [ super init ]) != nil) {
    element =
      [ [ NSXMLElement alloc ] initWithName:
        [ [ self class ] elementName ] ];
    [ element addNamespace:
      [ [ self class ] elementNamespace ] ];
  }
  return self;
}

- (id)initWithXMLElement:(NSXMLElement *)elem {
  if ((self = [ super init ]) != nil) {
    element = [ elem retain ];
  }
  return self;
}

- (id)initWithXMLString:(NSString *)string {
  if ((self = [ super init ]) != nil) {
    element =
      [ [ NSXMLElement alloc ] initWithXMLString:string
                                           error:nil ];
  }
  return self;
}

- (NSXMLDocument *)document {
  NSXMLDocument *doc = 
    [ [ [ NSXMLDocument alloc ] initWithRootElement: [ element copy ] ]
      autorelease ];
  return doc;
}

- (void)addElementWithNamespace:(NSXMLNode *)namespace
                    elementName:(NSString *)elementName
                          value:(NSString *)value {
  [ self addElementWithNamespace:namespace
                    elementName:elementName
                          value:value
                     attributes:nil];
}
- (void)addElementWithNamespace:(NSXMLNode *)namespace
                    elementName:(NSString *)elementName
                          value:(NSString *)value
                     attributes:(NSDictionary *)attributes {
  NSXMLElement *aElement =
    [ NSXMLElement elementWithName: elementName ];
  [ aElement addNamespace: namespace ];
  NSXMLNode *textNode = [ NSXMLNode textWithStringValue: value ];
  [ aElement addChild: textNode ];
  if (attributes != nil) {
    NSEnumerator *enumerator = [ attributes keyEnumerator ];
    NSString *attrKey, *attrValue;
    while ((attrKey = (NSString *)[enumerator nextObject]) != nil) {
      attrValue = (NSString *)[ attributes objectForKey:attrKey ];
      NSXMLNode *attr = [ NSXMLNode attributeWithName:attrKey
                                          stringValue:attrValue ];
      [ element addAttribute:attr ];
      [ attrKey release ];
    }
  }
  [ element addChild: aElement ];
}

- (void)addElementWithNamespace:(NSXMLNode *)namespace
                    elementName:(NSString *)elementName
                    atomElement:(AtomElement *)atomElement {
  [ self addElementWithNamespace:namespace
                     elementName:elementName
                         element:[ atomElement element ] ];
}
- (void)addElementWithNamespace:(NSXMLNode *)namespace
                    elementName:(NSString *)elementName
                        element:(NSXMLElement *)aElement {
  NSXMLElement *newElement =
    [ NSXMLElement elementWithName:elementName ];
  [ newElement addNamespace:namespace ];
  int i;
  int count = [ aElement childCount ];
  NSXMLNode *child;
  for (i = 0; i < count; i++) {
    child = [ aElement childAtIndex:i ];
    switch ([ child kind ]) {
      case NSXMLElementKind:
        [ newElement addChild:[ child copy ] ];
        break;
      case NSXMLTextKind:
        [ newElement addChild:
          [ NSXMLNode textWithStringValue:[ child stringValue ] ] ];
        break;
    }
  }
  NSArray *attributes = [ aElement attributes ];
  count = [ attributes count ];
  for (i = 0; i < count; i++) {
    [ newElement addAttribute:
      [ (NSXMLNode *)[ attributes objectAtIndex:i ] copy ] ];
  }
  [ element addChild:newElement ];
}

- (void)removeElementsWithNamespace:(NSXMLNode *)namespace
                        elementName:(NSString *)elementName {
  /*
  NSArray *elements =
    [ element elementsForLocalName:elementName
                               URI:[ namespace stringValue ]];
  if ([ elements count ] == 0)
    return;
  int i;
  int count = [ elements count ];
  for (i = 0; i < count; i++) {
    [ (NSXMLElement *)[ elements objectAtIndex:i ] detach ];
  }
  */
  int i = 0;
  while ( i < [ element childCount ] ) {
    NSXMLNode *child = [ element childAtIndex:i ];
    if ( [child kind ] == NSXMLElementKind
      && [ [ child localName ] isEqualToString:elementName ]
      && [ [ child URI ] isEqualToString:[ namespace stringValue ] ]) {
      [ element removeChildAtIndex:i ];
    } else {
      i++;
    }
  }
}

- (void)setElementWithNamespace:(NSXMLNode *)namespace
                    elementName:(NSString *)elementName
                          value:(NSString *)value {
  [ self removeElementsWithNamespace:namespace
                         elementName:elementName ];
  [ self addElementWithNamespace:namespace
                     elementName:elementName
                           value:value ];
}

- (void)setElementWithNamespace:(NSXMLNode *)namespace
                    elementName:(NSString *)elementName
                        element:(NSXMLElement *)aElement {
  [ self removeElementsWithNamespace:namespace
                         elementName:elementName ];
  [ self addElementWithNamespace:namespace
                     elementName:elementName
                         element:aElement ];
}

- (void)setElementWithNamespace:(NSXMLNode *)namespace
                    elementName:(NSString *)elementName
                    atomElement:(AtomElement *)atomElement {
  [ self removeElementsWithNamespace:namespace
                         elementName:elementName ];
  [ self addElementWithNamespace:namespace
                     elementName:elementName
                     atomElement:atomElement ];
}

- (NSXMLElement *)getElementWithNamespace:(NSXMLNode *)namespace
                              elementName:(NSString *)elementName {
  NSArray *elements =
    [ self getElementsWithNamespace:namespace 
                        elementName:elementName ];
  if ([ elements count ] > 0)
    return [ elements objectAtIndex:0 ];
  else
    return nil;
}

- (NSArray *)getElementsWithNamespace:(NSXMLNode *)namespace
                          elementName:(NSString *)elementName {
  NSArray *elements =
    [ element elementsForLocalName:elementName
                               URI:[ namespace stringValue ] ];
  return elements;
}

- (NSArray *)getElementsTextStringWithNamespace:(NSXMLNode *)namespace
                                    elementName:(NSString *)elementName {
  NSArray *elements =
    [ self getElementsWithNamespace:namespace
                        elementName:elementName ];
  int i;
  int count = [ elements count ];
  NSMutableArray *texts = [ NSMutableArray arrayWithCapacity:count ];
  for (i = 0; i < count; i++) {
    [ texts addObject: [ (NSXMLElement *)[ elements objectAtIndex:i ] stringValue ] ];
  }
  return texts;
}
- (NSString *)getElementTextStringWithNamespace:(NSXMLNode *)namespace
                                    elementName:(NSString *)elementName {
  NSXMLElement *elem =  [ self getElementWithNamespace:namespace
                                           elementName:elementName ];
  return (elem != nil) ? [ elem stringValue ] : nil;
}

- (NSString *)getAttributeValueForKey:(NSString *)key {
  NSXMLNode *attribute = [ element attributeForName:key ];
  return (attribute != nil) ? [ attribute stringValue ] : nil;
}

- (void)setAttributeValue:(NSString *)value
                 forKey:(NSString *)key {
  [ element addAttribute:
    [ NSXMLNode attributeWithName:key
                      stringValue:value ] ];
}

// @synthesize element;
- (NSXMLElement *)element {
  return [ [ element retain ] autorelease ];
}

- (void)dealloc {
  [ element release ];
  [ super dealloc ];
}

- (NSString *)stringValue {
  return [ [ NSString alloc ] initWithData:[ [ self document ] XMLData ]
                                  encoding:NSUTF8StringEncoding ];
}

- (NSArray *)getObjectsWithNamespace:(NSXMLNode *)namespace
                         elementName:(NSString *)elementName
                               class:(Class)class
                         initializer:(SEL)initializer {
  NSArray *list = [ self getElementsWithNamespace:namespace
                                      elementName:elementName ];
  int i;
  int count = [ list count ];
  NSMutableArray *filtered = [ NSMutableArray arrayWithCapacity:count ];
  for (i = 0; i < count; i++) {
    [ filtered addObject:[ class performSelector:initializer
                                      withObject:(NSXMLElement *)[ list objectAtIndex:i ] ] ];
  }
  return filtered;
}

- (id)getObjectWithNamespace:(NSXMLNode *)namespace
                 elementName:(NSString *)elementName
                       class:(Class)class
                 initializer:(SEL)initializer {
  NSXMLElement *elem = [ self getElementWithNamespace:namespace
                                          elementName:elementName ];
  return [ class performSelector:initializer
                      withObject:elem ];
}

@end

