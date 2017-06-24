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
    [self.tweetEditorTextView.layer setCornerRadius:3.0];
    [self.tweetEditorTextView setDelegate:self];
    [self.tweetEditorTextView becomeFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSInteger textLength = [textView.text length] + [text length] - range.length;
    
    int charCount = 140;
    charCount -= textLength;
    
    [self.characterCounterLabel setText:[NSString stringWithFormat:@"%d",charCount]];
    
    if (charCount < 140 && charCount >= 0) {
        [self.characterCounterLabel setTextColor:[UIColor greenColor]];
        if ([self delegate] && [[self delegate] respondsToSelector:@selector(enableEditorToSendTweetPost:)]) {
            [self.delegate enableEditorToSendTweetPost:YES];
        }
    } else {
        if (charCount == 140) {
            [self.characterCounterLabel setTextColor:[UIColor blackColor]];
        } else {
            [self.characterCounterLabel setTextColor:[UIColor redColor]];
        }
        if ([self delegate] && [[self delegate] respondsToSelector:@selector(enableEditorToSendTweetPost:)]) {
            [self.delegate enableEditorToSendTweetPost:NO];
        }
    }
    
    return YES;
}

@end
