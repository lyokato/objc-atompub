#import "AtompubClientTest.h"
#import "AtompubClient.h"
#import "AtomService.h"
#import "AtomWorkspace.h"
#import "AtomCategories.h"
#import "AtomCategory.h"
#import "AtomCollection.h"
#import "AtomFeed.h"
#import "AtomEntry.h"
#import "BasicCredential.h"

@implementation AtompubClientTest

- (void)testClient {
  client = [ AtompubClient client ];
  [ client setAgentName:@"MyAgent" ];
  [ client setDelegate:self ];
  BasicCredential *cred = [ BasicCredential credentialWithUsername:@"" password:@"" ];
  [ client setCredential:cred ];
  [ client startLoadingServiceWithURL:[ NSURL URLWithString:@"http://teahut.sakura.ne.jp:3000/service/" ] ];
}

- (void)client:(AtompubClient *)client
didReceiveService:(AtomService *)service {
  NSString *result = [ service stringValue ];
  STAssertEqualObjects( result, @"", nil );
  NSArray *collections = [ [ service workspace ] collections ];
  int count = [ collections count ];
  STAssertEquals((double)count, 2.0, nil);
}

- (void)client:(AtompubClient *)client
didReceiveCategories:(AtomCategories *)categories {

}

- (void)client:(AtompubClient *)client
didReceiveFeed:(AtomFeed *)feed {

}

- (void)client:(AtompubClient *)client
didReceiveEntry:(AtomEntry *)entry {

}

- (void)client:(AtompubClient *)client
didFailWithError:(NSError *)error {
  STAssertEqualObjects( error, @"hogehoge", nil );
}


@end
