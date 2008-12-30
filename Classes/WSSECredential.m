#import "WSSECredential.h"
#import "WSSEUsernameToken.h"

@implementation WSSECredential

- (void)setCredentialToRequest:(NSMutableURLRequest *)request {
  [ request setValue:@"WSSE profile=\"UsernameToken\"" forHTTPHeaderField:@"Authorization" ];
  NSString *token =
    [ WSSEUsernameToken generateUsernameTokenWithUsername:username
                                                 password:password ];
  [ request setValue:token forHTTPHeaderField:@"X-Wsse" ];
}

@end

