#import "AtomEntry.h"
#import "AtomControl.h"
#import "AtomNamespace.h"
#import "W3CDTF.h"

@implementation AtomEntry

+ (NSString *)elementName {
  return @"entry";
}

+ (NSXMLNode *)elementNamespace {
  return [ AtomNamespace atom ];
}

+ (AtomEntry *)entry {
  return [ [ [ AtomEntry alloc ] init ] autorelease ];
}

+ (AtomEntry *)entryWithXMLElement:(NSXMLElement *)elem {
  return [ [ [ AtomEntry alloc ] initWithXMLElement:elem ] autorelease ];
}

+ (AtomEntry *)entryWithXMLString:(NSString *)string {
  return [ [ [ AtomEntry alloc ] initWithXMLString:string ] autorelease ];
}

- (NSString *)summary {
  return [ self getElementTextStringWithNamespace:[ AtomNamespace atom ]
                                      elementName:@"summary" ];
}

- (void)setSummary:(NSString *)summary {
  [ self setElementWithNamespace:[ AtomNamespace atom ]
                     elementName:@"summary"
                           value:summary ];
}

- (NSDate *)published {
  NSString *published =
    [ self getElementTextStringWithNamespace:[ AtomNamespace atom ]
                                 elementName:@"published" ];
  return (published != nil) ? [ W3CDTF dateFromString:published ] : nil;
}

- (void)setPublished:(NSDate *)published {
  [ self setElementWithNamespace:[ AtomNamespace atom ]
                     elementName:@"updated"
                           value:[ W3CDTF stringFromDate:published ] ];
}

- (NSString *)source {
  return [ self getElementTextStringWithNamespace:[ AtomNamespace atom ]
                                      elementName:@"rights" ];
}

- (void)setSource:(NSString *)source {
  [ self setElementWithNamespace:[ AtomNamespace atom ]
                     elementName:@"source"
                           value:source];
}

- (AtomControl *)control {
  return [ self getObjectWithNamespace:[ AtomNamespace app ]
                           elementName:@"control"
                                 class:[ AtomControl class ]
                           initializer:@selector(controlWithXMLElement:) ];
}

- (NSArray *)controls {
  return [ self getObjectsWithNamespace:[ AtomNamespace app ]
                            elementName:@"control"
                                  class:[ AtomControl class ]
                            initializer:@selector(controlWithXMLElement:) ];
}

- (void)setControl:(AtomControl *)control {
  [ self setElementWithNamespace:[ AtomNamespace app ]
                     elementName:@"control"
                     atomElement:control ];
}

- (void)addControl:(AtomControl *)control {
  [ self addElementWithNamespace:[ AtomNamespace app ]
                     elementName:@"control"
                     atomElement:control ];
}

- (NSDate *)edited {
  NSString *edited =
    [ self getElementTextStringWithNamespace:[ AtomNamespace app ]
                                 elementName:@"edited" ];
  return (edited != nil) ? [ W3CDTF dateFromString:edited ] : nil;
}

- (void)setEdited:(NSDate *)edited {
  [ self setElementWithNamespace:[ AtomNamespace atom ]
                     elementName:@"edited"
                           value:[ W3CDTF stringFromDate:edited ] ];
}

@end
