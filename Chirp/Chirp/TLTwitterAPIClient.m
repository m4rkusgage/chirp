//
//  TLTwitterAPIClient.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-20.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "TLTwitterAPIClient.h"

@interface TLTwitterAPIClient ()
@property (strong, nonatomic) TLTwitterCredential *credential;
@end

@implementation TLTwitterAPIClient

+ (instancetype)sharedInstance
{
    static id sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"TwitterConfig" ofType:@"plist"];
        NSDictionary *config = [[NSDictionary alloc] initWithContentsOfFile:path];
        
        self.credential = [TLTwitterAPIClient retrieveCredentials];
        if (self.credential) {
            _twitterAPI = [STTwitterAPI twitterAPIWithOAuthConsumerKey:config[@"twitter_api_key"]  consumerSecret:config[@"twitter_api_key"]  oauthToken:self.credential.authToken oauthTokenSecret:self.credential.authTokenSecret];
        } else {
            _twitterAPI = [STTwitterAPI twitterAPIWithOAuthConsumerKey:config[@"twitter_api_key"] consumerSecret:config[@"twitter_api_secret"]];
        }
    }
    return self;
}

- (void)logInToTwitter
{
    [self.twitterAPI postTokenRequest:^(NSURL *url, NSString *oauthToken) {
        
        [[UIApplication sharedApplication] openURL:url
                                           options:@{}
                                 completionHandler:^(BOOL success) {}];
    
    } oauthCallback:@"tweetland://" errorBlock:^(NSError *error) {
    }];
}

- (void)getHomeTimeLineWithSuccess:(APISuccessBlock)success failure:(APIFailureBlock)failure
{
    [self.twitterAPI getHomeTimelineSinceID:nil count:10 successBlock:^(NSArray *statuses) {
        NSLog(@"Status: %@",statuses );
        success(statuses);
    } errorBlock:^(NSError *error) {
        failure(error);
    }];
}

- (void)requestTokenWithPin:(NSString *)pin success:(APIBlock)success failure:(APIBlock)failure
{
    [self.twitterAPI postAccessTokenRequestWithPIN:pin
                                      successBlock:^(NSString *oauthToken, NSString *oauthTokenSecret, NSString *userID, NSString *screenName) {
                                          
                                          if (!self.credential) {
                                              self.credential = [[TLTwitterCredential alloc] init];
                                          }
                                          [self.credential setUserID:userID];
                                          [self.credential setUserScreenName:screenName];
                                          [self.credential setAuthToken:oauthToken];
                                          [self.credential setAuthTokenSecret:oauthTokenSecret];
                                          [self.credential setVerifier:pin];
                                          
                                          NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.credential];
                                          [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"credential"];
                                          
                                          success(YES);
                                          
    } errorBlock:^(NSError *error) {
        failure(NO);
    }];
}

- (void)verifyCredentials:(APIBlock)success
{
    [self.twitterAPI verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {
        success(YES);
    } errorBlock:^(NSError *error) {
        success(NO);
    }];
}

+ (TLTwitterCredential *)retrieveCredentials
{
    NSData *credentialData = [[NSUserDefaults standardUserDefaults] objectForKey:@"credential"];
    
    if (!credentialData) {
        return nil;
    }
    TLTwitterCredential *credential = [NSKeyedUnarchiver unarchiveObjectWithData:credentialData];
    return credential;
}
@end
