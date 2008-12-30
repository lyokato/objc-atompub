#import "AtomNamespace.h";

@implementation AtomNamespace
+ (NSXMLNode *)atom {
  return [NSXMLNode namespaceWithName:@""
                          stringValue:@"http://www.w3.org/2005/Atom"];
}
+ (NSXMLNode *)atomWithPrefix {
  return [NSXMLNode namespaceWithName:@"atom"
                          stringValue:@"http://www.w3.org/2005/Atom"];
}
+ (NSXMLNode *)app {
  return [NSXMLNode namespaceWithName:@""
                          stringValue:@"http://www.w3.org/2007/app"];
}
+ (NSXMLNode *)appWithPrefix {
  return [NSXMLNode namespaceWithName:@"app"
                          stringValue:@"http://www.w3.org/2007/app"];
}
+ (NSXMLNode *)openSearch {
  return [NSXMLNode namespaceWithName:@"openSearch"
                          stringValue:@"http://a9.com/-/spec/opensearchrss/1.1/"];
}
+ (NSXMLNode *)threading {
  return [NSXMLNode namespaceWithName:@"thr"
                          stringValue:@"http://purl.org/syndication/thread/1.0"];
}
@end

