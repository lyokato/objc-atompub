#import <Foundation/Foundation.h>

@class AtomService, AtomCategories, AtomFeed, AtomEntry;
@class AtompubClient;

@protocol AtompubClientDelegate
- (void)clientDidReceiveService:(AtomService *)service;
- (void)clientDidReceiveCategories:(AtomCategories *)categories;
- (void)clientDidReceiveFeed:(AtomFeed *)feed;
- (void)clientDidReceiveEntry:(AtomEntry *)entry;
- (void)clientDidReceiveMedia:(NSData *)media;
- (void)clientDidCreateEntry:(AtomEntry *)entry
                withLocation:(NSURL *)location;
- (void)clientDidCreateMediaLinkEntry:(AtomEntry *)entry
                         withLocation:(NSURL *)location;
- (void)clientDidUpdateEntry;
- (void)clientDidUpdateMedia;
- (void)clientDidDeleteEntry;
- (void)clientDidDeleteMedia;
- (void)client:(AtompubClient *)client
didFailWithError:(NSError *)error;
@end
