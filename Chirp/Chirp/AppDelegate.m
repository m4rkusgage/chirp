//
//  AppDelegate.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-16.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "AppDelegate.h"
#import "TLTwitterAPIClient.h"
#import "TLLoginViewController.h"
#import "TLHomeTimelineTableViewController.h"

@interface AppDelegate ()
@property (strong, nonatomic) TLTwitterAPIClient *apiClient;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    __block UINavigationController *navigationController;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    [self.window.rootViewController.view setBackgroundColor:[UIColor whiteColor]];
    
    TLLoginViewController *loginController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    navigationController = [[UINavigationController alloc] initWithRootViewController:loginController];
    self.window.rootViewController = navigationController;
    
    if ([self.apiClient getLoginStatus]) {
        [loginController loadDataWithAccount:[self.apiClient getAuthorizedUser]];
        TLHomeTimelineTableViewController *homeTimeLine = [[TLHomeTimelineTableViewController alloc] init];
        [navigationController pushViewController:homeTimeLine animated:NO];
        [self.window makeKeyAndVisible];
    } else {
        [self.apiClient getiOSTwitterAccountForView:self.window.rootViewController.view
                                  completionHandler:^(ACAccount *twitterAccount) {
                                      [self.apiClient getProfileInfoOfAccount:twitterAccount
                                                                      forView:self.window.rootViewController.view
                                                            completionHandler:^(TLAuthUser *authUser) {
                                                                
                                                                
                                                                [loginController loadDataWithAccount:authUser];
                                                                [self.window makeKeyAndVisible];
                                                                
                                      }];
        }];
        
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (TLTwitterAPIClient *)apiClient
{
    if (!_apiClient) {
        _apiClient = [TLTwitterAPIClient sharedInstance];
    }
    return _apiClient;
}

@end
