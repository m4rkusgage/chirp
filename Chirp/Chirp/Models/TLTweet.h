//
//  TLTweet.h
//  Chirp
//
//  Created by Mark Gage on 2017-06-21.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLUser.h"

@interface TLTweet : NSObject<NSCoding>

@property (copy, nonatomic) NSString *tweetID;
@property (copy, nonatomic) NSString *tweetText;
@property (copy, nonatomic) NSString *tweetPostedAt;
@property (copy, nonatomic) NSString *retweetCount;
@property (copy, nonatomic) NSString *likeCount;
@property (strong, nonatomic) TLUser *postedByUser;

- (void)setDataWith:(NSDictionary *)dictionary;

@end
