#import "WSSEUsernameToken.h"
#import "SSCrypto.h"
#import "W3CDTF.h"

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
  SSCrypto *crypto = [ [ SSCrypto alloc ] init ];
  if (nonce == nil) {
    NSTimeInterval t = [ [ NSDate date ] timeIntervalSince1970 ];
    nonce = [ [ NSNumber numberWithDouble:t ] stringValue ];
  }
  [ crypto setClearTextWithString:nonce ];
  NSString *base64nonce = [ [ crypto clearTextAsData ] encodeBase64WithNewlines:NO ];
  if (timestamp == nil) {
    timestamp = [ NSDate date ];
  }
  NSString *created = [ W3CDTF stringFromDate:timestamp ];
  NSString *combined = [ NSString stringWithFormat:@"%@%@%@", nonce, created, password ];
  [ crypto setClearTextWithString:combined ];
  NSString *passwordDigest = [ [crypto digest:@"SHA1" ] encodeBase64WithNewlines:NO ];
  [ crypto release ];
  return [ NSString stringWithFormat:@"UsernameToken Username=\"%@\", PasswordDigest=\"%@\", Nonce=\"%@\", Created=\"%@\"",
    username, passwordDigest, base64nonce, created ];
}

@end

