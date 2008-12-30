#import <Foundation/Foundation.h>

@interface AtomElement : NSObject {
  NSXMLElement *element;
}


+ (NSString *)elementName;

+ (NSXMLNode *)elementNamespace;

- (id)init;

- (id)initWithXMLString:(NSString *)string;

- (id)initWithXMLElement:(NSXMLElement *)elem;

// XXX: @property(readonly) NSXMLElement *element;
- (NSXMLElement *)element;

- (NSXMLDocument *)document;

- (void)addElementWithNamespace:(NSXMLNode *)namespace
                    elementName:(NSString *)elementName
                          value:(NSString *)value;

- (void)addElementWithNamespace:(NSXMLNode *)namespace
                    elementName:(NSString *)elementName
                          value:(NSString *)value
                     attributes:(NSDictionary *)attributes;

- (void)removeElementsWithNamespace:(NSXMLNode *)namespace
                        elementName:(NSString *)elementName;

- (void)setElementWithNamespace:(NSXMLNode *)namespace
                    elementName:(NSString *)elementName
                          value:(NSString *)value;

- (NSXMLElement *)getElementWithNamespace:(NSXMLNode *)namespace
                              elementName:(NSString *)elementName;

- (NSArray *)getElementsWithNamespace:(NSXMLNode *)namespace
                          elementName:(NSString *)elementName;

- (NSArray *)getElementsTextStringWithNamespace:(NSXMLNode *)namespace
                                    elementName:(NSString *)elementName;
- (NSString *)getElementTextStringWithNamespace:(NSXMLNode *)namespace
                                    elementName:(NSString *)elementName;

- (void)addElementWithNamespace:(NSXMLNode *)namespace
                    elementName:(NSString *)elementName
                        element:(NSXMLElement *)aElement;

- (void)setElementWithNamespace:(NSXMLNode *)namespace
                    elementName:(NSString *)elementName
                        element:(NSXMLElement *)aElement;

- (void)addElementWithNamespace:(NSXMLNode *)namespace
                    elementName:(NSString *)elementName
                    atomElement:(AtomElement *)atomElement;

- (void)setElementWithNamespace:(NSXMLNode *)namespace
                    elementName:(NSString *)elementName
                    atomElement:(AtomElement *)atomElement;

- (NSString *)getAttributeValueForKey:(NSString *)key;
- (void)setAttributeValue:(NSString *)value
                   forKey:(NSString *)key;

- (void)dealloc;

- (NSString *)stringValue;

- (NSArray *)getObjectsWithNamespace:(NSXMLNode *)namespace
                         elementName:(NSString *)elementName
                               class:(Class)class
                         initializer:(SEL)initializer;

- (id)getObjectWithNamespace:(NSXMLNode *)namespace
                 elementName:(NSString *)elementName
                       class:(Class)class
                 initializer:(SEL)initializer;
@end

