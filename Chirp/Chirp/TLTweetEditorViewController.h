//
//  TLTweetEditorViewController.h
//  Chirp
//
//  Created by Mark Gage on 2017-06-22.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLTwitterAPIClient.h"

@interface TLTweetEditorViewController : UIViewController
- (void)loadDataWithAccount:(TLAuthUser *)account;
@end
