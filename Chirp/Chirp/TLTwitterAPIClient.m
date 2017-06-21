//
//  TLTwitterAPIClient.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-20.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "TLTwitterAPIClient.h"


@interface TLTwitterAPIClient ()
@property (strong, nonatomic) TLAuthUser *twitterAccount;
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
        NSData *authUser = [[NSUserDefaults standardUserDefaults] objectForKey:@"authUser"];
        if (authUser) {
            self.twitterAccount = [NSKeyedUnarchiver unarchiveObjectWithData:authUser];
        }
    }
    return self;
}

- (void)getiOSTwitterAccount:(void (^)(ACAccount *))completionHandler
{
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
        if (granted == YES)
        {
            NSArray *arrayOfAccounts = [accountStore accountsWithAccountType:accountType];
            
            if ([arrayOfAccounts count] > 0)
            {
                ACAccount *twitterAccount = [arrayOfAccounts objectAtIndex:0];
                [self.twitterAccount setTwitterAccount:twitterAccount];
                completionHandler(twitterAccount);
            }
        }
    }];
}

- (void)getProfileInfoOfAccount:(ACAccount *)account completionHandler:(void (^)(TLAuthUser *))completionHandler
{
    SLRequest *twitterInfoRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                       requestMethod:SLRequestMethodGET
                                                                 URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/account/verify_credentials.json"]
                                                          parameters:@{@"include_entities": @YES,
                                                                       @"skip_status": @YES}];
    
    [twitterInfoRequest setAccount:account];
    
    [twitterInfoRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (responseData) {
                NSError *error = nil;
                NSDictionary *twitterData = [NSJSONSerialization JSONObjectWithData:responseData
                                                                       options:NSJSONReadingMutableLeaves
                                                                         error:&error];
                NSLog(@"%@",twitterData);
                [self.twitterAccount setDataWith:[twitterData copy]];
                completionHandler(self.twitterAccount);
            }
        });
    }];
}

- (TLAuthUser *)twitterAccount
{
    if (!_twitterAccount) {
        _twitterAccount = [[TLAuthUser alloc] init];
    }
    return _twitterAccount;
}

- (TLAuthUser *)getAuthorizedUser
{
    return self.twitterAccount;
}

- (BOOL)login
{
    if ([self.twitterAccount twitterAccount]) {
        self.twitterAccount.loginStatus = YES;
        [self saveAuthUser];
        
        return YES;
    }
    return NO;
}

- (BOOL)logout
{
    self.twitterAccount.loginStatus = NO;
    [self saveAuthUser];
    
    return YES;
}

- (BOOL)getLoginStatus
{
    return [[self getAuthorizedUser] getLoginStatus];
}

- (void)saveAuthUser
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.twitterAccount];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"authUser"];
}
@end
