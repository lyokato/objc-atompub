#import "WSSEUsernameToken.h"
#import "W3CDTF.h"
#import <CommonCrypto/CommonDigest.h>
#import "Base64.h"

static NSString* encodeBase64(const char* bytes, size_t length)
{
    return nil;
}

@implementation WSSEUsernameToken

+ (NSString *)generateUsernameTokenWithUsername:(NSString *)username
                                       password:(NSString *)password {
  return [ [self class ] generateUsernameTokenWithUsername:username
                                                 password:password
                                                    nonce:nil
                                                timestamp:nil ];
}

+ (NSString *)generateUsernameTokenWithUsername:(NSString *)username
                                       password:(NSString *)password
                                          nonce:(NSString *)nonce
                                      timestamp:(NSDate *)timestamp {
  if (nonce == nil) {
    NSTimeInterval t = [ [ NSDate date ] timeIntervalSince1970 ];
    nonce = [ [ NSNumber numberWithDouble:t ] stringValue ];
  }

  NSData* nonceData = [nonce dataUsingEncoding: NSUTF8StringEncoding];
  NSString *base64nonce = Base64_encode([nonceData bytes] , [nonceData length]);
  if (timestamp == nil) {
    timestamp = [ NSDate date ];
  }
  NSString *created = [ W3CDTF stringFromDate:timestamp ];
  NSString *combined = [ NSString stringWithFormat:@"%@%@%@", nonce, created, password ];

  unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
  NSData* combinedData = [combined dataUsingEncoding: NSUTF8StringEncoding];
  CC_SHA1([combinedData bytes], [combinedData length], bytes);
  NSString *passwordDigest = Base64_encode(bytes, CC_SHA1_DIGEST_LENGTH);
  return [ NSString stringWithFormat:@"UsernameToken Username=\"%@\", PasswordDigest=\"%@\", Nonce=\"%@\", Created=\"%@\"",
    username, passwordDigest, base64nonce, created ];
}

@end

