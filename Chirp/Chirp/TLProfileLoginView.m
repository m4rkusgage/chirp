//
//  TLProfileLoginView.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-21.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "TLProfileLoginView.h"

@interface TLProfileLoginView ()

@end

@implementation TLProfileLoginView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.profileImageView.layer setCornerRadius:8.0];
    [self.profileImageView.layer setMasksToBounds:YES];
        
    [self.loginButton.layer setCornerRadius:5.0];
    [self.loginButton setBackgroundColor:[UIColor blueColor]];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton.titleLabel setFont:[UIFont boldSystemFontOfSize:[UIFont systemFontSize]]];
}

- (IBAction)loginButtonPressed:(id)sender
{
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(loginButtonWasPressed:)]) {
        [self.delegate loginButtonWasPressed:(UIButton *)sender];
    }
}

@end
