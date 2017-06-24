//
//  TLLoginViewController.h
//  Chirp
//
//  Created by Mark Gage on 2017-06-21.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLTwitterAPIClient.h"
#import "TLProfileLoginView.h"

@interface TLLoginViewController : UIViewController<TLLoginLogoutDelegate>

- (void)loadDataWithAccount:(TLAuthUser *)account;

@end
