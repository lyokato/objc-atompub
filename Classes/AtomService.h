#import <Foundation/Foundation.h>
#import "AtomElement.h"

@class AtomWorkspace;

@interface AtomService : AtomElement {

}
+ (NSString *)elementName;
+ (NSXMLNode *)elementNamespace;
+ (AtomService *)service;
+ (AtomService *)serviceWithXMLElement:(NSXMLElement *)elem;
+ (AtomService *)serviceWithXMLString:(NSString *)string;
- (AtomWorkspace *)workspace;
- (NSArray *)workspaces;
- (void)setWorkspace:(AtomWorkspace *)workspace;
- (void)addWorkspace:(AtomWorkspace *)workspace;
@end

