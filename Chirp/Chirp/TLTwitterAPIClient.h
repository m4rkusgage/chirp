//
//  TLTwitterAPIClient.h
//  Chirp
//
//  Created by Mark Gage on 2017-06-20.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "STTwitter.h"
#import "TLTwitterCredential.h"

@interface TLTwitterAPIClient : NSObject

typedef void (^APIBlock)(BOOL success);
typedef void (^APISuccessBlock)(id responseObject);
typedef void (^APIFailureBlock)(NSError *error);

@property (strong, nonatomic) STTwitterAPI *twitterAPI;

+ (instancetype)sharedInstance;
- (void)logInToTwitter;

- (void)getHomeTimeLineWithSuccess:(APISuccessBlock)success failure:(APIFailureBlock)failure;

- (void)requestTokenWithPin:(NSString *)pin success:(APIBlock)success failure:(APIBlock)failure;
- (void)verifyCredentials:(APIBlock)success;

+ (void)saveCredentials;
+ (TLTwitterCredential *)retrieveCredentials;
@end
