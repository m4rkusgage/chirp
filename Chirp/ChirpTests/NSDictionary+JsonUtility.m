//
//  NSDictionary+JsonUtility.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-23.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "NSDictionary+JsonUtility.h"

@implementation NSDictionary (JsonUtility)

+ (NSDictionary *)userDictionary
{
    NSDictionary *returnDictionary = @{@"description": @"Mashable is for superfans. We're not for the casually curious. Obsess with us.",
                                       @"id_str" : @"972651",
                                       @"name" :@"Mashable",
                                       @"notifications" : @"0",
                                       @"profile_background_image_url_https" : @"https://pbs.twimg.com/profile_background_images/705312036/bf7ca2a3f077d7e57b12a5ea4f1db268.png",
                                       @"profile_background_tile" :@"0",
                                       @"profile_banner_url" :@"https://pbs.twimg.com/profile_banners/972651/1401484849",
                                       @"profile_image_url" :@"http://pbs.twimg.com/profile_images/876132457896177664/6ir8C08C_normal.jpg",
                                       @"profile_image_url_https" :@"https://pbs.twimg.com/profile_images/876132457896177664/6ir8C08C_normal.jpg",
                                       @"screen_name" :@" mashable",
                                       @"statuses_count" : @241119,
                                       @"time_zone" :@"Eastern Time (US & Canada)",
                                       @"translator_type" :@"none;",
                                       @"url" :@"http://t.co/1Gm8aVACKn",
                                       @"utc_offset" : @"-14400",
                                       @"verified": @YES};

    
    return returnDictionary;
}

+ (NSDictionary *)tweetDictionary
{
    NSDictionary *returnDictionary = @{ @"id_str" :@"878357510087987201",
                                        @"source" :@"<a href=\"http://www.socialflow.com\" rel=\"nofollow\">SocialFlow</a>",
                                        @"text" :@"'MST3K' is getting a Twitch marathon, so you won't see daylight for a week\nhttps://t.co/hlPFST4CBa",
                                        @"truncated" :@0,
                                        @"created_at": @"Fri Jun 23 21:02:04 +0000 2017",
                                        @"user":@{@"description": @"Mashable is for superfans. We're not for the casually curious. Obsess with us.",
                                                  @"id_str" : @"972651",
                                                  @"name" :@"Mashable",
                                                  @"notifications" : @"0",
                                                  @"profile_background_image_url_https" : @"https://pbs.twimg.com/profile_background_images/705312036/bf7ca2a3f077d7e57b12a5ea4f1db268.png",
                                                  @"profile_background_tile" :@"0",
                                                  @"profile_banner_url" :@"https://pbs.twimg.com/profile_banners/972651/1401484849",
                                                  @"profile_image_url" :@"http://pbs.twimg.com/profile_images/876132457896177664/6ir8C08C_normal.jpg",
                                                  @"profile_image_url_https" :@"https://pbs.twimg.com/profile_images/876132457896177664/6ir8C08C_normal.jpg",
                                                  @"screen_name" :@" mashable",
                                                  @"statuses_count" : @241119,
                                                  @"time_zone" :@"Eastern Time (US & Canada)",
                                                  @"translator_type" :@"none;",
                                                  @"url" :@"http://t.co/1Gm8aVACKn",
                                                  @"utc_offset" : @"-14400",
                                                  @"verified": @YES}
                                        };
    return returnDictionary;
}

@end
