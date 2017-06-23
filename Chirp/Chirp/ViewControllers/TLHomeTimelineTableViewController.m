//
//  TLHomeTimelineTableViewController.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-22.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "TLHomeTimelineTableViewController.h"
#import "TLTwitterAPIClient.h"
#import "TLTweetTableViewCell.h"
#import "TLTweet.h"
#import "TLTweetButtonView.h"
#import "TLTweetEditorViewController.h"
#import "TLTweetPostDelegate.h"

@interface TLHomeTimelineTableViewController ()<UITableViewDelegate, UITableViewDataSource, TLTweetPostDelegate>
{
    int newTweetCounter;
}
@property (strong, nonatomic) TLTwitterAPIClient *apiClient;
@property (strong, nonatomic) TLTweetButtonView *tweetButton;
@property (strong, nonatomic) NSMutableArray *tweetList;
@property (strong, nonatomic) UILabel *notificationLabel;
@property (strong, nonatomic) UIBarButtonItem *userSettingButton;
@end

@implementation TLHomeTimelineTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.tweetButton];
    [self.view addSubview:self.notificationLabel];
    
    [self.navigationItem setTitle:@"Tweet Land"];
    self.navigationItem.leftBarButtonItem = self.userSettingButton;
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TLTweetTableViewCell" bundle:nil]
         forCellReuseIdentifier:@"tweetCell"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 150;
    
    [self updateData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateData)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

#pragma mark - Lazy Instantiation
- (TLTwitterAPIClient *)apiClient
{
    if (!_apiClient) {
        _apiClient = [TLTwitterAPIClient sharedInstance];
    }
    return _apiClient;
}

- (NSMutableArray *)tweetList
{
    if (!_tweetList) {
        _tweetList = [[NSMutableArray alloc] init];
    }
    return _tweetList;
}

- (TLTweetButtonView *)tweetButton
{
    if (!_tweetButton) {
        _tweetButton = [[TLTweetButtonView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 70, self.view.frame.size.height - 50, 60, 60)];
        [_tweetButton setDelegate:self];
    }
    return _tweetButton;
}

- (UILabel *)notificationLabel
{
    if (!_notificationLabel) {
        _notificationLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 40, self.navigationController.navigationBar.frame.size.height+20, 30, 20)];
        [_notificationLabel setBackgroundColor:[UIColor colorWithRed:(89.0/255.0) green:(192.0/255.0) blue:(227.0/255.0) alpha:1]];
        [_notificationLabel setTextColor:[UIColor whiteColor]];
        [_notificationLabel setTextAlignment:NSTextAlignmentCenter];
        [_notificationLabel setAlpha:0];
    }
    return _notificationLabel;
}

- (UIBarButtonItem *)userSettingButton
{
    if (!_userSettingButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(10.0, 2.0, 45.0, 40.0)];
        [button addTarget:self action:@selector(showProfileOpitions:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"profile_setting_img.png"] forState:UIControlStateNormal];
        
        _userSettingButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    }
    return _userSettingButton;
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tweetList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLTweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tweetCell" forIndexPath:indexPath];
    
    TLTweet *tweet = [self.tweetList objectAtIndex:indexPath.row];
    [cell addTweetData:tweet];
    
    return [cell updateCell];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self hideNotification];
    }
    if (indexPath.row == newTweetCounter - 1) {
        newTweetCounter--;
        [self.notificationLabel setText:[NSString stringWithFormat:@"%d", newTweetCounter]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.tweetButton.transform = CGAffineTransformMakeTranslation(0, self.tableView.contentOffset.y);
    self.notificationLabel.transform = CGAffineTransformMakeTranslation(0, self.tableView.contentOffset.y);
}


- (void)composeTweetWasPressed
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TLTweetEditorViewController *editor = [storyboard instantiateViewControllerWithIdentifier:@"TweetEditorViewController"];
    [editor loadDataWithAccount:[self.apiClient getAuthorizedUser]];
    
    [self.navigationController pushViewController:editor animated:YES];
}

- (void)showProfileOpitions:(id)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"LOGOUT"
                                                                             message:@"Do you want to log out of Twitter?"
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action)
                                   {}];
    UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"Logout"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action)
                               {
                                   [self.apiClient logout];
                                   [self.navigationController popToRootViewControllerAnimated:YES];
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:logoutAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)updateData
{
    if ([self.apiClient retrieveSavedTweetList]) {
        [self.tweetList addObjectsFromArray:[self.apiClient retrieveSavedTweetList]];
        [self.tableView reloadData];
        
        TLAuthUser *authUser = [self.apiClient getAuthorizedUser];
        TLTweet *lastTweet = [self.tweetList firstObject];
        [self.apiClient getHomeTimelineForAccount:authUser.twitterAccount
                                          forView:self.navigationController.view
                                          sinceID:lastTweet.tweetID
                                completionHandler:^(NSArray *tweets) {
                                    if (tweets) {
                                       
                                        //place newer tweets gotten to the front of the array
                                        NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0,[tweets count])];
                                        [self.tweetList insertObjects:tweets atIndexes:indexes];
                                        [self.apiClient saveTweetList:self.tweetList];
                                        [self.tableView reloadData];
                                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[tweets count]
                                                                                    inSection:0];
                                        [self.tableView scrollToRowAtIndexPath:indexPath
                                                              atScrollPosition:UITableViewScrollPositionTop
                                                                      animated:NO];
                                        newTweetCounter = (int)[tweets count];
                                        [self.notificationLabel setText:[NSString stringWithFormat:@"%d", newTweetCounter]];
                                        [self showNotification];
                                    }
                                }];
    } else {
        TLAuthUser *authUser = [self.apiClient getAuthorizedUser];
        [self.apiClient getHomeTimelineForAccount:authUser.twitterAccount
                                          forView:self.navigationController.view
                                          sinceID:@""
                                completionHandler:^(NSArray *tweets) {
                                    if (tweets) {
                                        [self.apiClient saveTweetList:tweets];
                                        [self.tweetList addObjectsFromArray:tweets];
                                        [self.tableView reloadData];
                                    }
                                }];
    }
}

- (void)showNotification
{
    if (newTweetCounter > 0) {
        [UIView animateWithDuration:2.0 animations:^{
            [self.notificationLabel setAlpha:1.0];
        }];
    }
}

- (void)hideNotification
{
    [UIView animateWithDuration:2.0 animations:^{
        [self.notificationLabel setAlpha:0];
    }];
}
@end
