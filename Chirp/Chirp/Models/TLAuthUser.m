//
//  TLAuthUser.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-21.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "TLAuthUser.h"

@implementation TLAuthUser

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        self.twitterAccount = [decoder decodeObjectForKey:@"twitterAccount"];
        self.loginStatus= [decoder decodeBoolForKey:@"loginStatus"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [super encodeWithCoder:encoder];
    [encoder encodeObject:_twitterAccount forKey:@"twitterAccount"];
    [encoder encodeBool:_loginStatus forKey:@"loginStatus"];
}

- (BOOL)getLoginStatus
{
    return _loginStatus;
}

@end
