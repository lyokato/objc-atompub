#import "AtompubCacheStorage.h"
#import "AtompubCache.h"

@implementation AtompubCacheStorage

+ (AtompubCacheStorage *)storage {
  return [ [ [ AtompubCacheStorage alloc ] init ] autorelease ];
}

- (id)init {
  if ((self = [ super init ]) != nil) {
    storage = [ [ NSMutableDictionary alloc ] init ];
  }
  return self;
}
- (void)setCache:(AtompubCache *)cache
          forURL:(NSURL *)url {
  [ storage setObject:cache
               forKey:[ url absoluteString ] ];
}
- (AtompubCache *)cacheForURL:(NSURL *)url {
  AtompubCache *cache = (AtompubCache *)[ storage objectForKey:[ url absoluteString ] ];
  return cache;
}
- (void)removeCacheForURL:(NSURL *)url {
  [ storage removeObjectForKey:[ url absoluteString ] ];
}
- (void)dealloc {
  [ storage release ];
  [ super dealloc ];
}
@end
