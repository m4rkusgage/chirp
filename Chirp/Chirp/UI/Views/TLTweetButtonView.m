//
//  TLTweetButtonView.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-22.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "TLTweetButtonView.h"

@interface TLTweetButtonView ()
@property (strong, nonatomic) UIButton *tweetButton;
@end

@implementation TLTweetButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tweetButton];
        [self.layer setCornerRadius:8.0];
        [self.layer setBorderColor:[UIColor colorWithRed:(89.0/255.0) green:(192.0/255.0) blue:(227.0/255.0) alpha:1.0].CGColor];
        [self.layer setBorderWidth:3.0];
        [self.layer setMasksToBounds:YES];
    }
    return self;
}

- (UIButton *)tweetButton
{
    if (!_tweetButton) {
        _tweetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tweetButton setFrame:self.bounds];
        [_tweetButton setImage:[UIImage imageNamed:@"compose_tweet.png"] forState:UIControlStateNormal];
        [_tweetButton addTarget:self action:@selector(tweetButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tweetButton;
}

- (void)tweetButtonPressed:(id)sender
{
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(composeTweetWasPressed)]) {
        [self.delegate composeTweetWasPressed];
    }
}
@end
