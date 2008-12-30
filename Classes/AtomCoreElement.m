#import "AtomCoreElement.h"
#import "AtomNamespace.h"
#import "AtomLink.h"
#import "AtomCategory.h"
#import "AtomPerson.h"
#import "W3CDTF.h"

@implementation AtomCoreElement

- (NSString *)ID {
  return [ self getElementTextStringWithNamespace:[ [ self class ] elementNamespace ]
                                      elementName:@"id" ];
}

- (void)setID:(NSString *)value {
  [ self setElementWithNamespace:[ [ self class ] elementNamespace ]
                     elementName:@"id"
                           value:value ];
}

- (NSString *)title {
  return [ self getElementTextStringWithNamespace:[ [ self class ] elementNamespace ]
                                      elementName:@"tltle" ];
}

- (void)setTitle:(NSString *)title {
  [ self setElementWithNamespace:[ [ self class ] elementNamespace ]
                     elementName:@"title"
                           value:title ];
}

- (NSString *)rights {
  return [ self getElementTextStringWithNamespace:[ [ self class ] elementNamespace ]
                                      elementName:@"rights" ];
}

- (void)setRights:(NSString *)rights {
  [ self setElementWithNamespace:[ [ self class ] elementNamespace ]
                     elementName:@"rights"
                           value:rights ];
}

- (NSDate *)updated {
  NSString *updated =
    [ self getElementTextStringWithNamespace:[ [ self class ] elementNamespace ]
                                 elementName:@"updated" ];
  return (updated != nil) ? [ W3CDTF dateFromString:updated ] : nil;
}

- (void)setUpdated:(NSDate *)updated {
  [ self setElementWithNamespace:[ [ self class ] elementNamespace ]
                     elementName:@"updated"
                           value:[ W3CDTF stringFromDate:updated ] ];
}

- (NSArray *)links {
  return [ self getObjectsWithNamespace:[ [ self class ] elementNamespace ]
                            elementName:@"link"
                                  class:[ AtomLink class ]
                            initializer:@selector(linkWithXMLElement:) ];
}

- (AtomLink *)link {
  return [ self getObjectWithNamespace:[ [ self class ] elementNamespace ]
                           elementName:@"link"
                                 class:[ AtomLink class ]
                           initializer:@selector(linkWithXMLElement:) ];
}

- (void)setLink:(AtomLink *)link {
  [ self setElementWithNamespace:[ [ self class ] elementNamespace ]
                     elementName:@"link"
                     atomElement:link];
}

- (void)addLink:(AtomLink *)link {
  [ self addElementWithNamespace:[ [ self class ] elementNamespace ]
                     elementName:@"link"
                     atomElement:link];
}

- (NSArray *)categories {
  return [ self getObjectsWithNamespace:[ [ self class ] elementNamespace ]
                            elementName:@"category"
                                  class:[ AtomCategory class ]
                            initializer:@selector(categoryWithXMLElement:) ];
}

- (AtomCategory *)category {
  return [ self getObjectWithNamespace:[ [ self class ] elementNamespace ]
                           elementName:@"category"
                                 class:[ AtomCategory class ]
                           initializer:@selector(categoryWithXMLElement:) ];
}

- (void)setCategory:(AtomCategory *)category {
  [ self addElementWithNamespace:[ [ self class ] elementNamespace ]
                     elementName:@"category"
                     atomElement:category ];
}

- (void)addCategory:(AtomCategory *)category {
  [ self addElementWithNamespace:[ [ self class ] elementNamespace ]
                     elementName:@"category"
                     atomElement:category ];
}

- (NSArray *)authors {
  return [ self getObjectsWithNamespace:[ [ self class ] elementNamespace ]
                            elementName:@"author"
                                  class:[ AtomPerson class ]
                            initializer:@selector(personWithXMLElement:) ];
}

- (AtomPerson *)author {
  return [ self getObjectWithNamespace:[ [ self class ] elementNamespace ]
                           elementName:@"author"
                                 class:[ AtomPerson class ]
                           initializer:@selector(personWithXMLElement:) ];
}

- (void)setAuthor:(AtomPerson *)author {
  [ self setElementWithNamespace:[ [ self class ] elementNamespace ]
                     elementName:@"author"
                     atomElement:author ];
}

- (void)addAuthor:(AtomPerson *)author {
  [ self addElementWithNamespace:[ [ self class ] elementNamespace ]
                     elementName:@"author"
                     atomElement:author ];
}

- (NSArray *)contributors {
  return [ self getObjectsWithNamespace:[ [ self class ] elementNamespace ]
                            elementName:@"contributor"
                                  class:[ AtomPerson class ]
                            initializer:@selector(personWithXMLElement:) ];
}

- (AtomPerson *)contributor {
  return [ self getObjectWithNamespace:[ [ self class ] elementNamespace ]
                           elementName:@"contributor"
                                 class:[ AtomPerson class ]
                           initializer:@selector(personWithXMLElement:) ];
}

- (void)setContributor:(AtomPerson *)contributor {
  [ self setElementWithNamespace:[ [ self class ] elementNamespace ]
                     elementName:@"contributor"
                     atomElement:contributor ];
}

- (void)addContributor:(AtomPerson *)contributor {
  [ self addElementWithNamespace:[ [ self class ] elementNamespace ]
                     elementName:@"contributor"
                     atomElement:contributor ];
}

- (NSArray *)linkURLsForRelType:(NSString *)relType {
  NSArray *elements =
    [ [ self element ] elementsForLocalName:@"link"
                                        URI:[ [ AtomNamespace atom ] stringValue ] ];
  int count = [ elements count ];
  int i;
  NSMutableArray *links = [ NSMutableArray array ];
  NSXMLElement *elem;
  NSXMLNode *attrRel, *attrHref;
  for (i = 0; i < count; i++) {
    elem = (NSXMLElement *)[ elements objectAtIndex:i ];
    attrRel = [ elem attributeForName:@"rel" ];
    attrHref = [ elem attributeForName:@"href" ];
    if ( attrRel  != nil
      && attrHref != nil
      && [ [ attrRel stringValue ] isEqualToString:relType ] ) {
      [ links addObject:
        [ NSURL URLWithString:[ attrHref stringValue ] ] ];
    }
  }
  return elements;
}

- (NSURL *)linkURLForRelType:(NSString *)relType {
  NSArray *links = [ self linkURLsForRelType:relType ];
  if ([ links count ] > 0)
    return [ links objectAtIndex:0 ];
  else
    return nil;
}

- (void)setLinkURL:(NSURL *)url
        forRelType:(NSString *)relType {
  NSArray *tmp =
    [ self getElementsWithNamespace:[ AtomNamespace atom ]
                        elementName:@"link"];
  [ self removeElementsWithNamespace:[ AtomNamespace atom ]
                         elementName:@"link" ];
  int count = [ tmp count ];
  int i;
  NSXMLElement *elem;
  NSXMLNode *rel;
  for (i = 0; i < count; i++) {
    elem = (NSXMLElement *)[ tmp objectAtIndex:i ];
    rel = [ elem attributeForName:@"rel" ];
    if (!(rel != nil && [ [ rel stringValue ] isEqualToString:relType ]))
      [ self addElementWithNamespace:[ AtomNamespace atom ]
                         elementName:@"link"
                             element:elem ];
  }
  [ self addLinkURL:url
         forRelType:relType ];
}

- (void)addLinkURL:(NSURL *)url
        forRelType:(NSString *)relType {
  AtomLink *link = [ AtomLink link ];
  [ link setHref:url ];
  [ link setRel:relType ];
  [ self addLink:link ];
}

- (NSURL *)alternateLink {
  NSArray *links = [ self alternateLinks ];
  if ([ links count ] > 0)
    return [ links objectAtIndex:0 ];
  else
    return nil;
}

- (NSArray *)alternateLinks {
  NSArray *tmp =
    [ self getElementsWithNamespace:[ AtomNamespace atom ]
                        elementName:@"link" ];
  int count = [ tmp count ];
  int i;
  NSMutableArray *links = [ NSMutableArray array ];
  NSXMLElement *elem;
  NSXMLNode *rel;
  NSXMLNode *href;
  for (i = 0; i < count; i++) {
    elem = (NSXMLElement *)[ tmp objectAtIndex:i ];
    rel = [ elem attributeForName:@"rel" ];
    href = [ elem attributeForName:@"href" ];
    if ((rel == nil
      || [ [ rel stringValue ] isEqualToString:@"alternate" ])
      && href != nil)
      [ links addObject:
        [ NSURL URLWithString:[ href stringValue ] ] ];
  }
  return links;
}

- (void)setAlternateLink:(NSURL *)link {
  [ self setLinkURL:link
         forRelType:@"alternate" ];
}

- (void)addAlternateLink:(NSURL *)link {
  [ self addLinkURL:link
         forRelType:@"alternate" ];
}

- (NSURL *)selfLink {
  return [ self linkURLForRelType:@"self" ];
}

- (NSArray *)selfLinks {
  return [ self linkURLsForRelType:@"self" ];
}

- (void)setSelfLink:(NSURL *)link {
  [ self setLinkURL:link
         forRelType:@"self" ];
}

- (void)addSelfLink:(NSURL *)link {
  [ self addLinkURL:link
         forRelType:@"self" ];
}

- (NSURL *)editLink {
  return [ self linkURLForRelType:@"edit" ];
}

- (NSArray *)editLinks {
  return [ self linkURLsForRelType:@"edit" ];
}

- (void)setEditLink:(NSURL *)link {
  [ self setLinkURL:link
         forRelType:@"edit" ];
}

- (void)addEditLink:(NSURL *)link {
  [ self addLinkURL:link
         forRelType:@"edit" ];
}

- (NSURL *)mediaLink {
  return [ self linkURLForRelType:@"media" ];
}

- (NSArray *)mediaLinks {
  return [ self linkURLsForRelType:@"media" ];
}

- (void)setMediaLink:(NSURL *)link {
  [ self setLinkURL:link
         forRelType:@"media" ];
}

- (void)addMediaLink:(NSURL *)link {
  [ self addLinkURL:link
         forRelType:@"media" ];
}

- (NSURL *)editMediaLink {
  return [ self linkURLForRelType:@"edit-media" ];
}

- (NSArray *)editMediaLinks {
  return [ self linkURLsForRelType:@"edit-media" ];
}

- (void)setEditMediaLink:(NSURL *)link {
  [ self setLinkURL:link
         forRelType:@"edit-media" ];
}

- (void)addEditMediaLink:(NSURL *)link {
  [ self addLinkURL:link
         forRelType:@"edit-media" ];
}

- (NSURL *)relatedLink {
  return [ self linkURLForRelType:@"related" ];
}

- (NSArray *)relatedLinks {
  return [ self linkURLsForRelType:@"related" ];
}

- (void)setRelatedLink:(NSURL *)link {
  [ self setLinkURL:link
         forRelType:@"related" ];
}

- (void)addRelatedLink:(NSURL *)link {
  [ self addLinkURL:link
         forRelType:@"related" ];
}

- (NSURL *)enclosureLink {
  return [ self linkURLForRelType:@"enclosure" ];
}

- (NSArray *)enclosureLinks {
  return [ self linkURLsForRelType:@"enclosure" ];
}

- (void)setEnclosureLink:(NSURL *)link {
  [ self setLinkURL:link
         forRelType:@"enclosure" ];
}

- (void)addEnclosureLink:(NSURL *)link {
  [ self addLinkURL:link
         forRelType:@"enclosure" ];
}

- (NSURL *)viaLink {
  return [ self linkURLForRelType:@"via" ];
}

- (NSArray *)viaLinks {
  return [ self linkURLsForRelType:@"via" ];
}

- (void)setViaLink:(NSURL *)link {
  [ self setLinkURL:link
         forRelType:@"via" ];
}

- (void)addViaLink:(NSURL *)link {
  [ self addLinkURL:link
         forRelType:@"via" ];
}

- (NSURL *)firstLink {
  return [ self linkURLForRelType:@"first" ];
}

- (void)setFirstLink:(NSURL *)link {
  [ self setLinkURL:link
         forRelType:@"first" ];
}

- (NSURL *)lastLink {
  return [ self linkURLForRelType:@"last" ];
}

- (void)setLastLink:(NSURL *)link {
  [ self setLinkURL:link
         forRelType:@"last" ];
}

- (NSURL *)previousLink {
  return [ self linkURLForRelType:@"previous" ];
}

- (void)setPreviousLink:(NSURL *)link {
  [ self setLinkURL:link
         forRelType:@"previous" ];
}

- (NSURL *)nextLink {
  return [ self linkURLForRelType:@"next" ];
}

- (void)setNextLink:(NSURL *)link {
  [ self setLinkURL:link
         forRelType:@"next" ];
}

@end

