#import "Foundation/Foundation.h"
#import "AtomElement.h"

@interface AtomContent : AtomElement {

}
+ (NSString *)elementName;
+ (NSXMLNode *)elementNamespace;
- (NSString *)type;
- (void)setType:(NSString *)aType;
- (NSURL *)src;
- (void)setSrc:(NSURL *)aSrc;
- (NSString *)body;
- (void)setBodyWithString:(NSString *)aBody;
- (void)setBodyWithXMLElement:(NSXMLElement *)aBody;
@end
