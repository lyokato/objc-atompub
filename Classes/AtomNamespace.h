#import <Foundation/Foundation.h>

@interface AtomNamespace : NSObject {
}
+ (NSXMLNode *)atom;
+ (NSXMLNode *)atomWithPrefix;
+ (NSXMLNode *)app;
+ (NSXMLNode *)appWithPrefix;
+ (NSXMLNode *)openSearch;
+ (NSXMLNode *)threading;
@end

