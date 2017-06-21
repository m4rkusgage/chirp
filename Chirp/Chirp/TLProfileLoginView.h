//
//  TLProfileLoginView.h
//  Chirp
//
//  Created by Mark Gage on 2017-06-21.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLLoginLogoutDelegate.h"

@interface TLProfileLoginView : UIView

@property (assign, nonatomic) id<TLLoginLogoutDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userScreenNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end
