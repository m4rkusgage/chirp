//
//  TLTweet.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-21.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "TLTweet.h"

@implementation TLTweet

- (void)setDataWith:(NSDictionary *)dictionary
{
    [self setTweetID:dictionary[@"id_str"]];
    [self setTweetText:dictionary[@"text"]];
    [self setTweetPostedAt:dictionary[@"created_at"]];
    [self setLikeCount:dictionary[@"favorite_count"]];
    [self setRetweetCount:dictionary[@"retweet_count"]];
    
    TLUser *user = [[TLUser alloc]  init];
    [user setDataWith:dictionary[@"user"]];
    [self setPostedByUser:user];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.tweetID = [decoder decodeObjectForKey:@"tweetID"];
        self.tweetText = [decoder decodeObjectForKey:@"tweetText"];
        self.tweetPostedAt = [decoder decodeObjectForKey:@"tweetPostedAt"];
        self.likeCount = [decoder decodeObjectForKey:@"likeCount"];
        self.retweetCount = [decoder decodeObjectForKey:@"retweetCount"];
        self.postedByUser = [decoder decodeObjectForKey:@"postedByUser"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_tweetID forKey:@"tweetID"];
    [encoder encodeObject:_tweetText forKey:@"tweetText"];
    [encoder encodeObject:_tweetPostedAt forKey:@"tweetPostedAt"];
    [encoder encodeObject:_likeCount forKey:@"likeCount"];
    [encoder encodeObject:_retweetCount forKey:@"retweetCount"];
    [encoder encodeObject:_postedByUser forKey:@"postedByUser"];
}

@end
