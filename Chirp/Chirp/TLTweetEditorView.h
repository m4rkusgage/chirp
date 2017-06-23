//
//  TLTweetEditorView.h
//  Chirp
//
//  Created by Mark Gage on 2017-06-22.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLTweetEditorView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;
@property (weak, nonatomic) IBOutlet UITextView *tweetEditorTextView;
@property (weak, nonatomic) IBOutlet UILabel *characterCounterLabel;

@end
