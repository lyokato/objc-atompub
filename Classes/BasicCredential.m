#import "BasicCredential.h"
#import "SSCrypto.h"

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
  SSCrypto *crypto = [ [ SSCrypto alloc ] init ];
  [ crypto setClearTextWithString:token ];
  NSString *token64 = [ [ crypto clearTextAsData ] encodeBase64WithNewlines:NO ];
  [ request setValue:[ NSString stringWithFormat:@"Basic %@", token64 ]
  forHTTPHeaderField:@"Authorization" ];
  [ crypto release ];
}

- (void)dealloc {
  [ username release ];
  [ password release ];
  [ super dealloc ];
}

@end

