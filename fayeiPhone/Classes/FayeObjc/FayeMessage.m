/* The MIT License
 
 Copyright (c) 2011 Paul Crawford
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE. */

//
//  FayeMessage.m
//  FayeObjC
//

#import "Channels.h"
#import "FayeMessage.h"
#import "JSONKit.h"
#import "NSObject+PropertySupport.h"
#import "NSObject+Serialize.h"

@implementation FayeMessage

@synthesize channel;
@synthesize clientId;
@synthesize successful;
@synthesize authSuccessful;
@synthesize version;
@synthesize minimumVersion;  
@synthesize supportedConnectionTypes;
@synthesize advice;
@synthesize error;
@synthesize subscription;
@synthesize timestamp;
@synthesize data;
@synthesize ext;
@synthesize fayeId;

- (id)initWithDictionary:(NSDictionary *)dict {
    if (!(self = [super init])) {
        return nil;
    }
    
    NSDictionary *objectPropertyNames = [[self class] propertyNamesAndTypes];
    for (NSString *propName in [FayeMessage propertyNames]) {
        if ([propName isEqualToString:@"data"] && [dict objectForKey:@"data"]) {
            self.data = [[dict objectForKey:@"data"] objectFromJSONString];
        }
        else if ([dict objectForKey:propName]) {
            Class propertyClass = [[self class] propertyClass:[objectPropertyNames objectForKey:propName]];
            id value = [propertyClass deserialize:[dict objectForKey:propName]];
            if (![value isEqual:[NSNull null]]) {    
                [self setValue:value forKey:propName];
            }
        }
    }
    
    return self;
}

- (NSString *)description {
    NSString *desc = @"\n";
    for (NSString *propName in [FayeMessage propertyNames]) {
        if([self valueForKey:propName])
            desc = [desc stringByAppendingFormat:@"%@ : %@\n", propName, [self valueForKey:propName]];    
    }
    
    return desc;
}

- (BOOL)isSuccessful {
    return [self.successful boolValue];
}

- (BayeuxChannel)channelTypeWithActiveChannel:(NSString *)activeChannel {
    if ([self.channel isEqualToString:HANDSHAKE_CHANNEL]) {
        return HANDSHAKE;
    }
    else if ([self.channel isEqualToString:CONNECT_CHANNEL]) {
        return CONNECT;
    }
    else if ([self.channel isEqualToString:DISCONNECT_CHANNEL]) {
        return DISCONNECT;
    }
    else if ([self.channel isEqualToString:SUBSCRIBE_CHANNEL]) {
        return SUBSCRIBE;
    }
    else if ([self.channel isEqualToString:UNSUBSCRIBE_CHANNEL]) {
        return UNSUBSCRIBE;
    }
    else if (activeChannel && [self.channel isEqualToString:activeChannel]) {
        return ACTIVE;
    }
    else {
        return OTHER;
    }
}

#pragma mark -

- (void) dealloc {
    [channel release];
    [clientId release];
    [successful release];
    [authSuccessful release];
    [version release];
    [minimumVersion release];
    [supportedConnectionTypes release];
    [advice release];
    [error release];
    [subscription release];
    [timestamp release];
    [data release];
    [ext release];
    [fayeId release];
    [super dealloc];
}


@end
