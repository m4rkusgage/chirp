//
//  TLHomeTimeLineViewController.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-21.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "TLHomeTimeLineViewController.h"
#import "TLTwitterAPIClient.h"

@interface TLHomeTimeLineViewController ()
@property (strong, nonatomic) TLTwitterAPIClient *apiClient;
@end

@implementation TLHomeTimeLineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    TLAuthUser *authUser = [self.apiClient getAuthorizedUser];
    [self.apiClient getHomeTimelineForAccount:authUser.twitterAccount forView:self.view sinceID:@"" completionHandler:^(NSArray *tweets) {
        NSLog(@"tweets: %@",tweets);
    }];
}

- (TLTwitterAPIClient *)apiClient
{
    if (!_apiClient) {
        _apiClient = [TLTwitterAPIClient sharedInstance];
    }
    return _apiClient;
}

@end
