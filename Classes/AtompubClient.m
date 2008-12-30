#import "AtompubClient.h"
#import "AtomService.h"
#import "AtomCategories.h"
#import "AtomFeed.h"
#import "AtomEntry.h"
#import "AtomNamespace.h"
#import "AtompubCredential.h"
#import "AtompubCache.h"
#import "AtompubCacheStorage.h"

@implementation AtompubClient

+ (AtompubClient *)client {
  return [ [ [ AtompubClient alloc ] init ] autorelease ];
}

- (id)init {
  if ((self = [ super init ]) != nil) {
    credential = nil;
    delegate = nil;
    cacheStorage = nil;
    agentName = @"objc-Atompub";
    timeoutInterval = defaultTimeoutInterval;
    fetchMode = None;
  }
  return self;
}

- (BOOL)isFetching {
  return (fetchMode != None) ? YES : NO;
}

- (NSString *)agentName {
  return [ [ agentName retain ] autorelease ];
}

- (void)setAgentName:(NSString *)name {
  [ name retain ];
  [ agentName release ];
  agentName = name;
}

- (AtompubCacheStorage *)cacheStorage {
  return [ [ cacheStorage retain ] autorelease ];
}

- (void)setCacheStorage:(AtompubCacheStorage *)storage {
  [ storage retain ];
  [ cacheStorage release ];
  cacheStorage = storage;
}

- (void)setCredential:(NSObject <AtompubCredential> *)aCredential {
  [ aCredential retain ];
  [ credential release ];
  credential = aCredential;
}

- (NSObject <AtompubClientDelegate> *)delegate {
  return [ [ delegate retain ] autorelease ] ;
}

- (void)setDelegate:(NSObject <AtompubClientDelegate> *)target {
  [ target retain ];
  [ delegate release ];
  delegate = target;
}

- (NSTimeInterval)timeoutInterval {
  return timeoutInterval;
}

- (NSData *)responseData {
  return responseData;
}

- (NSHTTPURLResponse *)lastResponse {
  return [ [ lastResponse retain ] autorelease ];
}

- (NSURL *)lastRequestURL {
  return [ [ lastRequestURL retain ] autorelease ];
}

- (void)setTimeoutInterval:(NSTimeInterval)interval {
  timeoutInterval = interval;
}

- (void)startLoadingServiceWithURL:(NSURL *)url {
  [ self startLoadingResponseWithURL:url
                                mode:GettingService ];
}

- (void)startLoadingCategoriesWithURL:(NSURL *)url {
  [ self startLoadingResponseWithURL:url
                                mode:GettingCategories ];
}

- (void)startLoadingFeedWithURL:(NSURL *)url {
  [ self startLoadingResponseWithURL:url
                                mode:GettingFeed ];
}

- (void)startLoadingEntryWithURL:(NSURL *)url {
  [ self startLoadingResponseWithURL:url
                                mode:GettingEntry ];
}

- (void)startLoadingMediaWithURL:(NSURL *)url {
  [ self startLoadingResponseWithURL:url
                                mode:GettingMedia ];
}

- (void)startLoadingResponseWithURL:(NSURL *)url
                               mode:(AtompubClientFetchMode)mode {
  if ([ self isFetching ])
    return;

  [ self clear ];

  lastRequestURL = [ url copy ];
  NSMutableURLRequest *request =
    [ NSMutableURLRequest requestWithURL:url
                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                         timeoutInterval:timeoutInterval ];
  [ request setHTTPMethod:@"GET" ];

  if (credential != nil)
    [ credential setCredentialToRequest:request ];

  if (mode == GettingEntry || mode == GettingMedia) {
  //switch (mode) {
    //case GettingEntry:
    //case GettingMedia:
      AtompubCache *cache = [ cacheStorage cacheForURL:url ];
      if (cache != nil) {
        if ([ cache etag ] != nil)
          [ request setValue:[ cache etag ]
          forHTTPHeaderField:@"If-None-Match" ];
        if ([ cache lastModified ] != nil)
          [ request setValue:[ cache lastModified ]
          forHTTPHeaderField:@"If-Modified-Since" ];
      }
      //break;
  }

  [ self startConnectionWithRequest:request
                               mode:mode ];
}

- (void)startCreatingEntry:(AtomEntry *)entry
                   withURL:(NSURL *)url {
  [ self startCreatingEntry:entry
                    withURL:url
                       slug:nil ];
}

- (void)startCreatingEntry:(AtomEntry *)entry
                   withURL:(NSURL *)url
                      slug:(NSString *)slug {

  NSData *resource = [ [ entry stringValue ] dataUsingEncoding:NSUTF8StringEncoding ];
  [ self startCreatingResource:resource
                       withURL:url
                   contentType:@"application/atom+xml;type=entry"
                          slug:slug
                          mode:PostingEntry ];
}

- (void)startCreatingMedia:(NSData *)resource
                   withURL:(NSURL *)url
               contentType:(NSString *)aType {
  [ self startCreatingMedia:resource
                    withURL:url
                contentType:aType
                       slug:nil ];
}

- (void)startCreatingMedia:(NSData *)resource
                   withURL:(NSURL *)url
               contentType:(NSString *)aType
                      slug:(NSString *)slug {

  [ self startCreatingResource:resource
                       withURL:url
                   contentType:aType
                          slug:slug
                          mode:PostingMedia ];
}


- (void)startCreatingResource:(NSData *)resource
                      withURL:(NSURL *)url
                  contentType:(NSString *)aType
                         slug:(NSString *)slug
                         mode:(AtompubClientFetchMode)mode {
  if ([ self isFetching ])
    return;

  [ self clear ];
  lastRequestURL = [ url copy ];
  NSMutableURLRequest *request =
    [ NSMutableURLRequest requestWithURL:url
                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                         timeoutInterval:timeoutInterval ];
  [ request setHTTPMethod:@"POST" ];
  [ request setValue:aType
  forHTTPHeaderField:@"Content-Type" ];
  if (slug != nil)
    [ request setValue:slug
    forHTTPHeaderField:@"Slug" ];

  [ request setHTTPBody:resource ];
  // content-length
  // [ request setValue:[[NSNumber numberWithInt:[body length]] stringValue] forHTTPHeaderField:@"Content-Length"];

  if (credential != nil)
    [ credential setCredentialToRequest:request ];

  [ self startConnectionWithRequest:request
                               mode:mode ];
}

- (void)startUpdatingEntry:(AtomEntry *)entry
                   withURL:(NSURL *)url {
  NSData *resource = [ [ entry stringValue ] dataUsingEncoding:NSUTF8StringEncoding ];
  [ self startUpdatingResource:resource
                       withURL:url
                   contentType:@"application/atom+xml;type=entry"
                          mode:PuttingEntry ];
}

- (void)startUpdatingMedia:(NSData *)resource
                   withURL:(NSURL *)url
               contentType:(NSString *)aType {

  [ self startUpdatingResource:resource
                       withURL:url
                   contentType:aType
                          mode:PuttingMedia ];
}


- (void)startUpdatingResource:(NSData *)resource
                      withURL:(NSURL *)url
                  contentType:(NSString *)aType
                         mode:(AtompubClientFetchMode)mode {

  if ([ self isFetching ])
    return;

  [ self clear ];
  lastRequestURL = [ url copy ];
  NSMutableURLRequest *request =
    [ NSMutableURLRequest requestWithURL:url
                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                         timeoutInterval:timeoutInterval ];
  [ request setHTTPMethod:@"PUT" ];
  [ request setValue:aType
  forHTTPHeaderField:@"Content-Type" ];

  [ request setHTTPBody:resource ];
  // content-length
  // [ request setValue:[[NSNumber numberWithInt:[resource length]] stringValue] forHTTPHeaderField:@"Content-Length"];

  AtompubCache *cache = [ cacheStorage cacheForURL:url ];
  if (cache != nil) {
    if ([ cache etag ] != nil)
      [ request setValue:[ cache etag ]
      forHTTPHeaderField:@"If-Match" ];
    if ([ cache lastModified ] != nil)
      [ request setValue:[ cache lastModified ]
      forHTTPHeaderField:@"If-Not-Modified-Since" ];
  }

  if (credential != nil)
    [ credential setCredentialToRequest:request ];

  [ self startConnectionWithRequest:request
                               mode:mode ];
}

- (void)startDeletingEntryWithURL:(NSURL *)url {
  [ self startDeletingResourceWithURL:url
                                 mode:DeletingEntry ];
}

- (void)startDeletingMediaWithURL:(NSURL *)url {
  [ self startDeletingResourceWithURL:url
                                 mode:DeletingMedia ];
}

- (void)startDeletingResourceWithURL:(NSURL *)url
                                mode:(AtompubClientFetchMode)mode {
  if ([ self isFetching ])
    return;

  [ self clear ];
  lastRequestURL = [ url copy ];
  NSMutableURLRequest *request =
    [ NSMutableURLRequest requestWithURL:url
                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                         timeoutInterval:timeoutInterval ];
  [ request setHTTPMethod:@"DELETE" ];

  if (credential != nil)
    [ credential setCredentialToRequest:request ];

  [ self startConnectionWithRequest:request
                               mode:mode ];
}

- (void)startConnectionWithRequest:(NSMutableURLRequest *)request
                              mode:(AtompubClientFetchMode)mode {
  connection = [ [ NSURLConnection alloc ] initWithRequest:request
                                                  delegate:self ];
  if (connection) {
    NSLog(@"connected successfully");
    fetchMode = mode;
    responseData = [ [ NSMutableData alloc ] init ];
  } else {
    NSLog(@"failed to connect");
    // clear data
    [ self closeConnection ];
    [ self dispatchErrorWithStatus:0
                       description:@"Failed to connect to server." ];
  }
}

- (void)connection:(NSURLConnection *)conn
didReceiveResponse:(NSURLResponse *)response {
  lastResponse = (NSHTTPURLResponse *)[ response retain ];
  [ responseData setLength:0 ];
}

- (void)connection:(NSURLConnection *)conn
    didReceiveData:(NSData *)data {
  [ responseData appendData:data ];
}

- (void)connection:(NSURLConnection *)conn
  didFailWithError:(NSError *)error {
  [ self closeConnection ];
  [ self clear ];
  if (delegate != nil &&
    [ delegate respondsToSelector:@selector(client:didFailWithError:) ]) {
    [ delegate performSelector:@selector(client:didFailWithError:)
                    withObject:[ [ self retain ] autorelease ]
                    withObject:error ];
  }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn {

  NSLog(@"finished loading");
  AtompubClientFetchMode mode = fetchMode;

  [ self closeConnection ];

  switch (mode) {

  case GettingService:
      NSLog(@"Got service");
      [ self handleResponseWithType:@"application/atomsvc+xml"
                         dispatcher:@selector(clientDidReceiveService:)
                              class:[ AtomService class ] ];
      break;
  case GettingCategories:
      NSLog(@"Got categories");
      [ self handleResponseWithType:@"application/atomcat+xml"
                         dispatcher:@selector(clientDidReceiveCategories:)
                              class:[ AtomCategories class ] ];
      break;
  case GettingFeed:
      NSLog(@"Got feed");
      [ self handleResponseWithType:@"application/atom+xml;type=feed"
                         dispatcher:@selector(clientDidReceiveFeed:)
                              class:[ AtomFeed class ] ];
      break;
  case GettingEntry:
      NSLog(@"Got entry");
      [ self handleResponseForGettingEntry ];
      break;
  case GettingMedia:
      NSLog(@"Got media");
      [ self handleResponseForGettingMedia ];
      break;
  case PostingEntry:
      NSLog(@"Posted entry");
      [ self handleResponseForPostingResourceWithDispatcher:
        @selector(clientDidCreateEntry:withLocation:) ];
      break;
  case PostingMedia:
      NSLog(@"Posted media");
      [ self handleResponseForPostingResourceWithDispatcher:
        @selector(clientDidCreateMediaLinkEntry:withLocation:) ];
      break;
  case PuttingEntry:
      NSLog(@"Putted entry");
      [ self handleResponseForPuttingOrDeletingResourceWithDispatcher:
        @selector(clientDidUpdateEntry) ];
      break;
  case PuttingMedia:
      NSLog(@"Putted media");
      [ self handleResponseForPuttingOrDeletingResourceWithDispatcher:
        @selector(clientDidUpdateMedia) ];
      break;
  case DeletingEntry:
      NSLog(@"Deleted entry");
      [ self handleResponseForPuttingOrDeletingResourceWithDispatcher:
        @selector(clientDidDeleteEntry) ];
      break;
  case DeletingMedia:
      NSLog(@"Deleted media");
      [ self handleResponseForPuttingOrDeletingResourceWithDispatcher:
        @selector(clientDidDeleteMedia) ];
      break;
  }
}

- (void)handleResponseForPuttingOrDeletingResourceWithDispatcher:(SEL)dispatcher {

  int status = [ lastResponse statusCode ];
  NSString *message = [ NSHTTPURLResponse localizedStringForStatusCode:status ];
  //NSDictionary *headers = [ lastResponse allHeaderFields ];

  if (status >= 200 && status < 300) {
    if (status != 200 && status != 204)
      NSLog(@"Bad status code: %d", status);
    [ cacheStorage removeCacheForURL:lastRequestURL ];
    if (delegate != nil
      && [ delegate respondsToSelector:dispatcher ])
      [ delegate performSelector:dispatcher ];
  } else {
    [ self dispatchErrorWithStatus:status
                       description:message ];
  }
}

- (void)handleResponseForPostingResourceWithDispatcher:(SEL)dispatcher {

  int status = [ lastResponse statusCode ];
  NSString *message = [ NSHTTPURLResponse localizedStringForStatusCode:status ];
  NSDictionary *headers = [ lastResponse allHeaderFields ];

  if (status >= 200 && status < 300) {

    if (status != 201)
      NSLog(@"Bad status code: %d", status);

    NSString *type = (NSString *)[ headers objectForKey:@"Content-Type" ];
    if (![ type isEqualToString:@"application/atom+xml;type=entry" ])
      NSLog(@"Bad Content-Type: %@", type);

    NSString *location = (NSString *)[ headers objectForKey:@"Location" ];
    if (location == nil)
      [ self dispatchErrorWithStatus:status
                         description:@"Location not found." ];

    //gen entry
    NSXMLDocument *doc =
      [ [ NSXMLDocument alloc ] initWithData:responseData
                                     options:NSXMLNodeOptionsNone
                                       error:nil ];
    if (doc == nil) {
      [ self dispatchErrorWithStatus:status
                         description:@"Failed to parse response data." ];
    } else {
      if ( delegate != nil
        && [ delegate respondsToSelector:dispatcher ] )
      [ delegate performSelector:dispatcher
                      //withObject:[ [ self retain ] autorelease ]
                      withObject:[ AtomEntry entryWithXMLElement:[ doc rootElement ] ]
                      withObject:[ NSURL URLWithString:location ] ];
    }
  } else {
    [ self dispatchErrorWithStatus:status
                       description:message ];
  }
}

- (void)handleResponseForGettingEntry {

  int status = [ lastResponse statusCode ];
  NSString *message = [ NSHTTPURLResponse localizedStringForStatusCode:status ];
  NSDictionary *headers = [ lastResponse allHeaderFields ];

  if (status == 200) {

    NSString *type = (NSString *)[ headers objectForKey:@"Content-Type" ];
    //if (![ type isEqualToString:@"application/atomsvc+xml" ])
    if (![ type isEqualToString:@"application/atom+xml;type=entry" ])
      NSLog(@"Bad Content-Type: %@", type);
    if (cacheStorage != nil) {
      AtompubCache *newCache = [ AtompubCache cache ];
      NSString *lastModified = (NSString *)[ headers objectForKey:@"Last-Modified" ];
      if (lastModified != nil)
        [ newCache setLastModified:lastModified ];
      NSString *etag = (NSString *)[ headers objectForKey:@"ETag" ];
      if (etag != nil)
        [ newCache setEtag:etag ];
      [ newCache setResource:[ responseData copy ] ];
      [ cacheStorage setCache:newCache
                       forURL:lastRequestURL ];
    }
    NSXMLDocument *doc =
      [ [ NSXMLDocument alloc ] initWithData:responseData
                                     options:NSXMLNodeOptionsNone
                                       error:nil ];
    if (doc == nil) {
      [ self dispatchErrorWithStatus:status
                         description:@"Failed to parse response data." ];
    } else {
      if (delegate != nil
        && [ delegate respondsToSelector:@selector(clientDidReceiveEntry:) ] ) {
        [ delegate performSelector:@selector(clientDidReceiveEntry:)
                        withObject:[ AtomEntry entryWithXMLElement:[ doc rootElement ] ] ];
      }
    }
  } else if (status == 304) {
    AtompubCache *cache = [ cacheStorage cacheForURL:lastRequestURL ]; 
    if (cache == nil) {
      [ self dispatchErrorWithStatus:status
                         description:@"Couldn't found proper cache resource." ];
    } else {
      NSData *resource = [ cache resource ];
      NSXMLDocument *cachedDoc =
        [ [ NSXMLDocument alloc ] initWithData:resource
                                       options:NSXMLNodeOptionsNone
                                         error:nil ];
      if (cachedDoc == nil) {
        [ self dispatchErrorWithStatus:status
                           description:@"Failed to parse response data." ];
      } else {
        if (delegate != nil
          && [ delegate respondsToSelector:@selector(clientDidReceiveEntry:) ] ) {
          [ delegate performSelector:@selector(clientDidReceiveEntry:)
                          withObject:[ AtomEntry entryWithXMLElement:[ cachedDoc rootElement ] ] ];
        }
      }
    }
  } else {
    [ self dispatchErrorWithStatus:status
                       description:message ];
  }
}

- (void)handleResponseForGettingMedia {

  int status = [ lastResponse statusCode ];
  NSString *message = [ NSHTTPURLResponse localizedStringForStatusCode:status ];
  NSDictionary *headers = [ lastResponse allHeaderFields ];

  if (status == 200) {

    //NSString *type = (NSString *)[ headers objectForKey:@"Content-Type" ];
    if (cacheStorage != nil) {
      AtompubCache *newCache = [ AtompubCache cache ];
      NSString *lastModified = (NSString *)[ headers objectForKey:@"Last-Modified" ];
      if (lastModified != nil)
        [ newCache setLastModified:lastModified ];
      NSString *etag = (NSString *)[ headers objectForKey:@"ETag" ];
      if (etag != nil)
        [ newCache setEtag:etag ];
      [ newCache setResource:[ responseData copy ] ];
      [ cacheStorage setCache:newCache
                       forURL:lastRequestURL ];
    }
    if (delegate != nil
      && [ delegate respondsToSelector:@selector(clientDidReceiveMedia:) ] ) {
      [ delegate performSelector:@selector(clientDidReceiveMedia:)
                      withObject:[ [ responseData retain ] autorelease ] ];
    }
  } else if (status == 304) {
    AtompubCache *cache = [ cacheStorage cacheForURL:lastRequestURL ]; 
    if (cache == nil) {
      [ self dispatchErrorWithStatus:status
                         description:@"Couldn't found proper cache resource." ];
    } else {
      NSData *resource = [ cache resource ];
      if (delegate != nil
        && [ delegate respondsToSelector:@selector(clientDidReceiveMedia:) ] ) {
        [ delegate performSelector:@selector(clientDidReceiveMedia:)
                        withObject:resource ];
      }
    }
  } else {
    [ self dispatchErrorWithStatus:status
                       description:message ];
  }
}

- (void)handleResponseWithType:(NSString *)aType
                    dispatcher:(SEL)dispatcher
                         class:(Class)class {

  int status = [ lastResponse statusCode ];
  NSString *message = [ NSHTTPURLResponse localizedStringForStatusCode:status ];
  NSDictionary *headers = [ lastResponse allHeaderFields ];

  if (status == 200) {

    NSString *type = (NSString *)[ headers objectForKey:@"Content-Type" ];
    //if (![ type isEqualToString:@"application/atomsvc+xml" ])
    if (![ type isEqualToString:aType ])
      NSLog(@"Bad Content-Type: %@", type);
    NSXMLDocument *doc =
      [ [ NSXMLDocument alloc ] initWithData:responseData
                                     options:NSXMLNodeOptionsNone
                                       error:nil ];
    if (doc == nil) {
      [ self dispatchErrorWithStatus:status
                         description:@"Failed to parse response data." ];
    } else {
      if (delegate != nil
        && [ delegate respondsToSelector:dispatcher ] ) {
        [ delegate performSelector:dispatcher
                        withObject:[ [ [ class alloc ] initWithXMLElement:[ doc rootElement ] ] autorelease ] ];
      }
    }
  } else {
    [ self dispatchErrorWithStatus:status
                       description:message ];
  }
}

- (void)dispatchErrorWithStatus:(int)status
                    description:(NSString *)description {
  if (delegate != nil
    && [ delegate respondsToSelector:@selector(client:didFailWithError:) ]) {
    NSMutableDictionary *info = [ NSMutableDictionary dictionary ];
    if (description != nil)
      [ info setObject:description
                forKey:NSLocalizedDescriptionKey ];
    NSError *error = [ NSError errorWithDomain:NSURLErrorDomain
                                          code:status
                                      userInfo:info ];
    [ delegate performSelector:@selector(client:didFailWithError:)
                    withObject:[ [ self retain ] autorelease ]
                    withObject:error ];
  }
}

- (void)cancel {
  if (connection != nil) {
    [ connection cancel ];
    [ self closeConnection ];
  }
}

- (void)closeConnection {
  if (connection != nil) {
    [ connection release ];
    connection = nil;
    fetchMode = None;
  }
}

- (void)clear {
  [ responseData release ];
  responseData = nil;
  [ lastResponse release ];
  lastResponse = nil;
  [ lastRequestURL release ];
  lastRequestURL = nil;
}

- (void)dealloc {
  [ self clear ];
  [ agentName release ];
  [ cacheStorage release ];
  [ credential release ];
  [ delegate release ];
  [ super dealloc ];
}

@end

