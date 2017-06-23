//
//  TLTweetEditorView.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-22.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "TLTweetEditorView.h"

@interface TLTweetEditorView ()<UITextViewDelegate>
{
    int characterCount;
}
@end

@implementation TLTweetEditorView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    characterCount = 140;
    
    [self.profilePicImageView.layer setCornerRadius:8.0];
    [self.profilePicImageView.layer setMasksToBounds:YES];
    
    [self.tweetEditorTextView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.tweetEditorTextView.layer setBorderWidth:0.5];
    [self.tweetEditorTextView setDelegate:self];
    [self.tweetEditorTextView becomeFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView
{
    characterCount -= textView.text.length;
    [self.characterCounterLabel setText:[NSString stringWithFormat:@"%d",characterCount]];
    
    if (characterCount < 140 && characterCount >= 0) {
        [self.characterCounterLabel setTextColor:[UIColor greenColor]];
        if ([self delegate] && [[self delegate] respondsToSelector:@selector(enableEditorToSendTweetPost:)]) {
            [self.delegate enableEditorToSendTweetPost:YES];
        }
    } else {
        if (characterCount == 140) {
            [self.characterCounterLabel setTextColor:[UIColor blackColor]];
        } else {
            [self.characterCounterLabel setTextColor:[UIColor redColor]];
        }
        if ([self delegate] && [[self delegate] respondsToSelector:@selector(enableEditorToSendTweetPost:)]) {
            [self.delegate enableEditorToSendTweetPost:NO];
        }
    }
}


@end
