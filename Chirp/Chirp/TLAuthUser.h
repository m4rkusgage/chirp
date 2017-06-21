//
//  TLAuthUser.h
//  Chirp
//
//  Created by Mark Gage on 2017-06-21.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "TLUser.h"
#import <Accounts/Accounts.h>

@interface TLAuthUser : TLUser<NSCoding>

@property (strong, nonatomic) ACAccount *twitterAccount;
@property (assign, nonatomic, getter=getLoginStatus) BOOL loginStatus;

@end
