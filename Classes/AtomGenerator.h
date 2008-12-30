#import <Foundation/Foundation.h>
#import "AtomElement.h"

@interface AtomGenerator : AtomElement {

}
+ (NSString *)elementName;
+ (NSXMLNode *)elementNamespace;
+ (AtomGenerator *)generator;
+ (AtomGenerator *)generatorWithXMLElement:(NSXMLElement *)elem;
+ (AtomGenerator *)generatorWithXMLString:(NSString *)string;

// @property NSString *name, *version;
- (NSString *)name;
- (void)setName:(NSString *)name;

- (NSString *)version;
- (void)setVersion:(NSString *)version;

// @property NSURL *url;
- (NSURL *)url;
- (void)setUrl:(NSURL *)url;

@end

