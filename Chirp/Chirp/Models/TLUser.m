//
//  TLUser.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-21.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "TLUser.h"
#import "NSString+TLUtilities.h"

@implementation TLUser

- (void)setDataWith:(NSDictionary *)dictionary
{
    [self setUserID:dictionary[@"id_str"]];
    [self setUserName:dictionary[@"name"]];
    [self setUserScreenName:dictionary[@"screen_name"]];
    [self setProfileDescription:dictionary[@"description"]];
    [self setProfileImageURL:[NSString removeSuffixString:@"_normal"
                                               fromString:[dictionary[@"profile_image_url_https"] mutableCopy]]];
    [self setProfileBannerURL:dictionary[@"profile_banner_url"]];
    [self setIsVerified:[dictionary[@"verified"] boolValue]];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.userID = [decoder decodeObjectForKey:@"userID"];
        self.userName = [decoder decodeObjectForKey:@"userName"];
        self.userScreenName = [decoder decodeObjectForKey:@"userScreenName"];
        self.profileDescription = [decoder decodeObjectForKey:@"profileDescription"];
        self.profileImageURL = [decoder decodeObjectForKey:@"profileImageURL"];
        self.profileBannerURL = [decoder decodeObjectForKey:@"profileBannerURL"];
        self.isVerified = [decoder decodeBoolForKey:@"isVerified"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_userID forKey:@"userID"];
    [encoder encodeObject:_userName forKey:@"userName"];
    [encoder encodeObject:_userScreenName forKey:@"userScreenName"];
    [encoder encodeObject:_profileDescription forKey:@"profileDescription"];
    [encoder encodeObject:_profileImageURL forKey:@"profileImageURL"];
    [encoder encodeObject:_profileBannerURL forKey:@"profileBannerURL"];
    [encoder encodeBool:_isVerified forKey:@"isVerified"];
}

@end
