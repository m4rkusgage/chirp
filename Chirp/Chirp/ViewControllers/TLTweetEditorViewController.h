//
//  TLTweetEditorViewController.h
//  Chirp
//
//  Created by Mark Gage on 2017-06-22.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLTwitterAPIClient.h"

@protocol TLTweetEditorViewControllerDelegate <NSObject>
- (void)newPostedTweet:(TLTweet *)tweet;
@end

@interface TLTweetEditorViewController : UIViewController

@property (assign, nonatomic) id<TLTweetEditorViewControllerDelegate> delegate;

- (void)loadDataWithAccount:(TLAuthUser *)account;

@end
