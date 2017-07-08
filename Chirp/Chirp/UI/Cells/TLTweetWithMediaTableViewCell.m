//
//  TLTweetWithMediaTableViewCell.m
//  Chirp
//
//  Created by Mark Gage on 2017-07-07.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "TLTweetWithMediaTableViewCell.h"
#import "UIKit+AFNetworking.h"
#import "NSString+TLUtilities.h"
#import "NSMutableAttributedString+TLUtilities.h"
#import "TLEntity.h"

@interface TLTweetWithMediaTableViewCell ()
@property (strong, nonatomic) TLTweet *tweet;
@property (assign, nonatomic) BOOL hasImage;
@end

@implementation TLTweetWithMediaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.profilePic.layer setCornerRadius:8.0];
    [self.profilePic.layer setMasksToBounds:YES];
    
    [self.assetImageView.layer setCornerRadius:3.0];
    [self.assetImageView.layer setMasksToBounds:YES];
    [self.assetImageView.layer setBorderColor:[UIColor colorWithRed:(179.0/255.0) green:(179.0/255.0) blue:(179.0/255.0) alpha:1.0].CGColor];
    [self.assetImageView.layer setBorderWidth:0.5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addTweetData:(TLTweet *)tweet
{
    self.tweet = tweet;
}

- (TLTweetWithMediaTableViewCell *)updateCell
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
    
    [self.retweetCountLabel setText:self.tweet.retweetCount];
    [self.favouriteCountLabel setText:self.tweet.likeCount];
    
    if (self.tweet.isFavourited) {
        [self.favouriteCountLabel setHighlighted:YES];
        [self.favouriteImageView setHighlighted:YES];
    } else {
        [self.favouriteCountLabel setHighlighted:NO];
        [self.favouriteImageView setHighlighted:NO];
    }
    
    if (self.tweet.isRetweet) {
        [self.retweetCountLabel setHighlighted:YES];
        [self.retweetImageView setHighlighted:YES];
    } else {
        [self.retweetCountLabel setHighlighted:NO];
        [self.retweetImageView setHighlighted:NO];
    }
    
    for (TLEntity *entity in self.tweet.entityArray) {
        if (entity.entityType == TLEntityTypePhoto) {
           [self.assetImageView setImageWithURL:[NSURL URLWithString:entity.mediaURLString]];
        } else {
            [self.assetImageView setImage:nil];
        }
    }
    return self;
}

@end
