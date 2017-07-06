//
//  TLTweetTableViewCell.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-22.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "TLTweetTableViewCell.h"
#import "UIKit+AFNetworking.h"
#import "NSString+TLUtilities.h"
#import "NSMutableAttributedString+TLUtilities.h"

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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)addTweetData:(TLTweet *)tweet
{
    self.tweet = tweet;
}

- (TLTweetTableViewCell *)updateCell
{
    [self.userName setText:self.tweet.postedByUser.userName];
    [self.twitterHandle setText:[NSString stringWithFormat:@"@%@",self.tweet.postedByUser.userScreenName]];
    
    [self.tweetText setAttributedText:[NSMutableAttributedString decorateWithTags:self.tweet.tweetText]];
    
    [self.tweetDateLabel setText:[NSString getTweetTimeIntervalString:self.tweet.tweetPostedAt]];
    if (![self.tweet.postedByUser isVerified]) {
        [self.verifiedPic setAlpha:0];
    } else {
        [self.verifiedPic setAlpha:1.0];
    }
    [self.profilePic setImageWithURL:[NSURL URLWithString:self.tweet.postedByUser.profileImageURL]];
    
    return self;
}



@end
