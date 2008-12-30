#import "AtomControl.h"
#import "AtomNamespace.h"

@implementation AtomControl

// @dynamic draft;
+ (NSString *)elementName {
  return @"control";
}

+ (NSXMLNode *)elementNamespace {
  return [ AtomNamespace app ];
}

+ (AtomControl *)control {
  return [ [ [ AtomControl alloc ] init ] autorelease ]; 
}

+ (AtomControl *)controlWithXMLElement:(NSXMLElement *)elem {
  return [ [ [ AtomControl alloc ] initWithXMLElement:elem ] autorelease ]; 
}

+ (AtomControl *)controlWithXMLString:(NSString *)string {
  return [ [ [ AtomControl alloc ] initWithXMLString:string ] autorelease ]; 
}

- (BOOL)draft {
  NSString *isDraft =
    [ self getElementTextStringWithNamespace:[ AtomNamespace app ]
                                 elementName:@"draft" ];
  if (isDraft == nil)
    return NO;
  return ([ isDraft isEqualToString:@"yes" ]) ? YES : NO;
}

- (void)setDraft:(BOOL)draft {
  NSString *isDraft = (draft == YES) ? @"yes" : @"no";
  [ self setElementWithNamespace:[ AtomNamespace app ]
                     elementName:@"draft"
                           value:isDraft ];
}

@end

