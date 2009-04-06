#import "WSSEUsernameTokenTest.h"
#import "../Atompub/WSSEUsernameToken.h"

@implementation WSSEUsernameTokenTest
- (void) testGenerateUsernameToken
{
	NSString* s;
    s = [WSSEUsernameToken generateUsernameTokenWithUsername: @"kenji@example.com"
                                                    password: @"password"
                                                       nonce: @"hello"
                                                   timestamp: [NSDate dateWithTimeIntervalSince1970: 0]];
    STAssertEqualObjects(s,
                         @"UsernameToken Username=\"kenji@example.com\", PasswordDigest=\"svxy579LmlY/42rW0aUJlFuuFoI=\", Nonce=\"aGVsbG8=\", Created=\"1970-01-01T00:00:00Z\"",
                         nil);
}
@end
