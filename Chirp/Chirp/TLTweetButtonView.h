//
//  TLTweetButtonView.h
//  Chirp
//
//  Created by Mark Gage on 2017-06-22.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TLTweetDelegate <NSObject>
- (void)composeTweetWasPressed;
@end

@interface TLTweetButtonView : UIView
@property (assign, nonatomic) id<TLTweetDelegate> delegate;
@end
