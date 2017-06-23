//
//  TLLoginLogoutDelegate.h
//  Chirp
//
//  Created by Mark Gage on 2017-06-21.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TLLoginLogoutDelegate <NSObject>

@optional
- (void)loginButtonWasPressed:(UIButton *)button;
- (void)logoutButtonWasPressed:(UIButton *)button;

@end
