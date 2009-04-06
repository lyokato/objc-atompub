#include "Base64.h"

NSString* Base64_encode(const unsigned char* bytes, size_t length)
{
    const char* s = ("ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                     "abcdefghijklmnopqrstuvwxyz"
                     "0123456789+/");
    NSMutableString* result = [NSMutableString string];
    int i;

    for (i = 0; i < length; i += 3) {
        int j;
        unsigned char buffer[3];
        for (j = 0; j < 3; j++) {
            if (i + j < length) {
                buffer[j] = bytes[i + j];
            } else {
                buffer[j] = 0;
            }
        }
        [result appendFormat: @"%c", s[ buffer[0] >> 2] ];
        [result appendFormat: @"%c", s[ ((buffer[0] << 4) & 0x30) | ((buffer[1] >> 4) & 0xf)] ];

        if (i + 1 < length) {
            [result appendFormat: @"%c", s[ ((buffer[1] << 2) & 0x3c) | ((buffer[2] >> 6) & 0x3)] ];
        } else {
            [result appendString: @"="];
        }
        if (i + 2 < length) {
            [result appendFormat: @"%c", s[buffer[2] & 0x3f]];
        } else {
            [result appendString: @"="];
        }
    }

    return result;
}

#if 0
int main(int argc, char* argv[])
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

    char* src = argv[1];
    printf("%s\n", [Base64_encode((unsigned char*) src, strlen(src)) UTF8String]);
    [pool release];
}
#endif
