#import "BasicCredential.h"
#import "Base64.h"

@implementation BasicCredential

+ (id)credentialWithUsername:(NSString *)username
                    password:(NSString *)password {
  return [ [ [ [ self class ] alloc ] initWithUsername:username
                                              password:password ] autorelease ];
}

- (id)initWithUsername:(NSString *)name
              password:(NSString *)pass {
  if (self = [super init]) {
    username = [ name retain ];
    password = [ pass retain ];
  }
  return self;
}

- (void)setCredentialToRequest:(NSMutableURLRequest *)request {
  NSString *token = [ NSString stringWithFormat:@"%@:%@", username, password ];
  NSData* tokenData = [token dataUsingEncoding: NSASCIIStringEncoding];
  NSString *token64 = Base64_encode([tokenData bytes], [tokenData length]);
  [ request setValue:[ NSString stringWithFormat:@"Basic %@", token64 ]
  forHTTPHeaderField:@"Authorization" ];
}

- (void)dealloc {
  [ username release ];
  [ password release ];
  [ super dealloc ];
}

@end

