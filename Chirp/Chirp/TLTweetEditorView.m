//
//  TLTweetEditorView.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-22.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "TLTweetEditorView.h"

@implementation TLTweetEditorView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.profilePicImageView.layer setCornerRadius:8.0];
    [self.profilePicImageView.layer setMasksToBounds:YES];
}

@end
