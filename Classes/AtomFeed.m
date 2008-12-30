#import "AtomFeed.h"
#import "AtomNamespace.h"
#import "AtomEntry.h"

@implementation AtomFeed

+ (NSString *)elementName {
  return @"feed";
}

+ (NSXMLNode *)elementNamespace {
  return [ AtomNamespace atom ];
}

- (NSURL *)icon {
  NSString *icon =
    [ self getElementTextStringWithNamespace:[ AtomNamespace atom ]
                                 elementName:@"icon" ];  
  return (icon != nil) ? [ NSURL URLWithString:icon ] : nil;
}

- (void)setIcon:(NSURL *)icon {
  [ self setElementWithNamespace:[ AtomNamespace atom ]
                     elementName:@"icon"
                           value:[ icon absoluteString ] ];
}

- (NSURL *)logo {
  NSString *logo =
    [ self getElementTextStringWithNamespace:[ AtomNamespace atom ]
                                 elementName:@"logo" ];  
  return (logo != nil) ? [ NSURL URLWithString:logo ] : nil;
}

- (void)setLogo:(NSURL *)logo {
  [ self setElementWithNamespace:[ AtomNamespace atom ]
                     elementName:@"logo"
                           value:[ logo absoluteString ] ];
}

- (NSString *)subtitle {
  return [ self getElementTextStringWithNamespace:[ AtomNamespace atom ]
                                      elementName:@"subtitle" ];  
}

- (void)setSubtitle:(NSString *)subtitle {
  [ self setElementWithNamespace:[ AtomNamespace atom ]
                     elementName:@"subtitle"
                           value:subtitle ];
}

- (AtomGenerator *)generator {
  return [ self getObjectWithNamespace:[ AtomNamespace atom ]
                           elementName:@"generator"
                                 class:[ AtomGenerator class ]
                           initializer:@selector(generatorWithXMLElement:) ];
}

- (void)setGenerator:(AtomGenerator *)generator {
  [ self setElementWithNamespace:[ AtomNamespace atom ]
                     elementName:@"generator"
                     atomElement:(AtomElement *)generator ];
}

- (NSString *)version {
  return [ self getAttributeValueForKey:@"version" ];
}

- (void)setVersion:(NSString *)version {
  [ self setAttributeValue:version
                    forKey:@"version" ];
}

- (int)totalResults {
  NSString *results = 
    [ self getElementTextStringWithNamespace:[ AtomNamespace openSearch ]
                                 elementName:@"totalResults" ];
  return (results != nil) ? [ results intValue ] : nil;
}

- (void)setTotalResults:(int)num {
  [ self setElementWithNamespace:[ AtomNamespace openSearch ]
                     elementName:@"totalResults"
                           value:[ [ NSNumber numberWithInt:num ] stringValue ] ];
}

- (int)startIndex {
  NSString *index = 
    [ self getElementTextStringWithNamespace:[ AtomNamespace openSearch ]
                                 elementName:@"startIndex" ];
  return (index != nil) ? [ index intValue ] : nil;
}

- (void)setStartIndex:(int)num {
  [ self setElementWithNamespace:[ AtomNamespace openSearch ]
                     elementName:@"startIndex"
                           value:[ [ NSNumber numberWithInt:num ] stringValue ] ];
}

- (int)itemsPerPage {
  NSString *page = 
    [ self getElementTextStringWithNamespace:[ AtomNamespace openSearch ]
                                 elementName:@"itemsPerPage" ];
  return (page != nil) ? [ page intValue ] : nil;
}

- (void)setItemsPerPage:(int)num {
  [ self setElementWithNamespace:[ AtomNamespace openSearch ]
                     elementName:@"itemsPerPage"
                           value:[ [ NSNumber numberWithInt:num ] stringValue ] ];
}

- (AtomEntry *)entry {
  return [ self getObjectWithNamespace:[ AtomNamespace atom ]
                           elementName:@"entry"
                                 class:[ AtomEntry class ]
                           initializer:@selector(entryWithXMLElement:) ];
}

- (NSArray *)entries {
  return [ self getObjectsWithNamespace:[ AtomNamespace atom ]
                            elementName:@"entry"
                                  class:[ AtomEntry class ]
                            initializer:@selector(entryWithXMLElement:) ];
}

- (void)setEntry:(AtomEntry *)entry {
  [ self setElementWithNamespace:[ AtomNamespace atom ]
                     elementName:@"entry"
                     atomElement:entry ];
}

- (void)addEntry:(AtomEntry *)entry {
  [ self addElementWithNamespace:[ AtomNamespace atom ]
                     elementName:@"entry"
                     atomElement:entry ];
}

@end
