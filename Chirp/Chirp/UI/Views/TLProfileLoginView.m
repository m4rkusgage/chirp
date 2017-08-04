//
//  TLProfileLoginView.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-21.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "TLProfileLoginView.h"

@implementation TLProfileLoginView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.profileImageView.layer setCornerRadius:75.0];
    [self.profileImageView.layer setMasksToBounds:YES];
    [self.profileImageView.layer setBorderWidth:3.0];
    [self.profileImageView.layer setBorderColor:[UIColor whiteColor].CGColor];
        
    [self.loginButton.layer setCornerRadius:5.0];
    [self.loginButton.layer setBorderWidth:3.0];
    [self.loginButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    
}

- (IBAction)loginButtonPressed:(id)sender
{
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(loginButtonWasPressed:)]) {
        [self.delegate loginButtonWasPressed:(UIButton *)sender];
    }
}

@end
