//
//  TLTweetTableViewCell.h
//  Chirp
//
//  Created by Mark Gage on 2017-06-22.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLTweet.h"

@interface TLTweetTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *twitterHandle;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *tweetDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favouriteCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *verifiedPic;
@property (weak, nonatomic) IBOutlet UIImageView *favouriteImageView;
@property (weak, nonatomic) IBOutlet UIImageView *retweetImageView;

- (void)addTweetData:(TLTweet *)tweet;
- (TLTweetTableViewCell *)updateCell;

@end
