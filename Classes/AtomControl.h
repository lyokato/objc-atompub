#import <Foundation/Foundation.h>
#import "AtomElement.h"

@interface AtomControl : AtomElement {

}

+ (NSString *)elementName;
+ (NSXMLNode *)elementNamespace;
+ (AtomControl *)control;
+ (AtomControl *)controlWithXMLElement:(NSXMLElement *)elem;
+ (AtomControl *)controlWithXMLString:(NSString *)string;

// @property BOOL draft;
- (BOOL)draft;
- (void)setDraft:(BOOL)draft;
@end

