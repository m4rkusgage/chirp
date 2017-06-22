//
//  TLTweetTableViewCell.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-22.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "TLTweetTableViewCell.h"
#import "UIKit+AFNetworking.h"

@interface TLTweetTableViewCell ()
@property (strong, nonatomic) TLTweet *tweet;
@end

@implementation TLTweetTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    
    [self.profilePic.layer setCornerRadius:8.0];
    [self.profilePic.layer setMasksToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addTweetData:(TLTweet *)tweet
{
    self.tweet = tweet;
}

- (TLTweetTableViewCell *)updateCell
{
    [self.userName setText:self.tweet.postedByUser.userName];
    [self.twitterHandle setText:[NSString stringWithFormat:@"@%@",self.tweet.postedByUser.userScreenName]];
    [self.tweetText setText:self.tweet.tweetText];
    [self.tweetDateLabel setText:[self getTweetTimeIntervalString:self.tweet.tweetPostedAt]];
    if (![self.tweet.postedByUser isVerified]) {
        [self.verifiedPic setAlpha:0];
    } else {
        [self.verifiedPic setAlpha:1.0];
    }
    [self.profilePic setImageWithURL:[NSURL URLWithString:self.tweet.postedByUser.profileImageURL]];
    return self;
}

- (NSString *)getTweetTimeIntervalString:(NSString *)tweetTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setDateFormat: @"EEE MMM dd HH:mm:ss Z yyyy"];
    
    NSDate *date = [dateFormatter dateFromString:tweetTime];
    NSDate *now = [NSDate date];
    
    NSTimeInterval seconds = [now timeIntervalSinceDate:date];
    
    if(seconds < 60) {
        return [[NSString alloc] initWithFormat:@"%.0fs", seconds];
    }
    else if(seconds < 3600) {
        return [[NSString alloc] initWithFormat:@"%.0fm", seconds/60];
    }
    else if(seconds < 3600 * 24) {
        return [[NSString alloc] initWithFormat:@"%.0fh", seconds/3600];
    }
    else if(seconds < 3600 * 24 * 365) {
        return [[NSString alloc] initWithFormat:@"%.0fd", seconds/3600/24];
    }
    else {
        return [[NSString alloc] initWithFormat:@"%.0fy", seconds/3600/24/365];
    }
}

@end
