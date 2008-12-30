#import <Foundation/Foundation.h>
#import "AtomElement.h"

@class AtomCategories;

@interface AtomCollection : AtomElement {

}
+ (NSString *)elementName;
+ (NSXMLNode *)elementNamespace;
+ (AtomCollection *)collection;
+ (AtomCollection *)collectionWithXMLElement:(NSXMLElement *)elem;
+ (AtomCollection *)collectionWithXMLString:(NSString *)string;
// @property NSString *title;
- (NSString *)title;
- (void)setTitle:(NSString *)title;
// @property NSURL *href;
- (NSURL *)href;
- (void)setHref:(NSURL *)url;
// @property AtomCategories *categories;
- (AtomCategories *)categories;
- (void)setCategories:(AtomCategories *)categories;

// @property NSString *accept;
- (NSString *)accept;
- (NSArray *)accepts;
- (void)setAccept:(NSString *)accept;
- (void)addAccept:(NSString *)accept;
@end

