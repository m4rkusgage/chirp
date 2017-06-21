//
//  TLTwitterCredential.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-20.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "TLTwitterCredential.h"

@implementation TLTwitterCredential

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.userID = [decoder decodeObjectForKey:@"userID"];
        self.userScreenName = [decoder decodeObjectForKey:@"userScreenName"];
        self.authToken = [decoder decodeObjectForKey:@"authToken"];
        self.authTokenSecret = [decoder decodeObjectForKey:@"authTokenSecret"];
        self.verifier = [decoder decodeObjectForKey:@"verifier"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_userID forKey:@"userID"];
    [encoder encodeObject:_userScreenName forKey:@"userScreenName"];
    [encoder encodeObject:_authToken forKey:@"authToken"];
    [encoder encodeObject:_authTokenSecret forKey:@"authTokenSecret"];
    [encoder encodeObject:_verifier forKey:@"verifier"];
}

@end
