//
//  TLTwitterAPIClient.h
//  Chirp
//
//  Created by Mark Gage on 2017-06-20.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "TLAuthUser.h"

@interface TLTwitterAPIClient : NSObject

+ (instancetype)sharedInstance;

- (BOOL)login;
- (BOOL)logout;
- (BOOL)getLoginStatus;

- (void)getiOSTwitterAccountForView:(UIView *)view completionHandler:(void (^)(ACAccount *twitterAccount))completionHandler;
- (void)getProfileInfoOfAccount:(ACAccount *)account forView:(UIView *)view completionHandler:(void (^)(TLAuthUser *authUser))completionHandler;

- (TLAuthUser *)getAuthorizedUser;
@end
