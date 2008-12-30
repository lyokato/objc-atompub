#import "AtompubCache.h"

@implementation AtompubCache

+ (AtompubCache *)cache {
  return [ [ [ AtompubCache alloc ] init ] autorelease ];
}

- (id)init {
  if ((self = [super init]) != nil) {
    lastModified = nil;
    etag = nil;
    resource = nil;
  }
  return self;
}

- (NSString *)lastModified {
  return [ [ lastModified retain ] autorelease ];
}

- (void)setLastModified:(NSString *)date {
  [ date retain ];
  [ lastModified release ];
  lastModified = date;
}

- (NSString *)etag {
  return [ [ etag retain ] autorelease ];
}

- (void)setEtag:(NSString *)value {
  [ value retain ]; 
  [ etag release ];
  etag = value;
}

- (NSData *)resource {
  return [ [ resource retain ] autorelease ];
}

- (void)setResource:(NSData *)newData {
  [ newData retain ];
  [ resource release ];
  resource = newData;
}

- (void)dealloc {
  [ lastModified release ];
  [ etag release ];
  [ resource release ];
  [ super dealloc ];
}

@end

