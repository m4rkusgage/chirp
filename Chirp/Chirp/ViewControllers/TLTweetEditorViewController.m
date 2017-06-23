//
//  TLTweetEditorViewController.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-22.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "TLTweetEditorViewController.h"
#import "TLTweetEditorView.h"
#import "UIKit+AFNetworking.h"

@interface TLTweetEditorViewController ()<TLTweetPostDelegate>
{
    BOOL isAllowedToPost;
}

@property (weak, nonatomic) IBOutlet TLTweetEditorView *editorView;
@property (strong, nonatomic) TLTwitterAPIClient *apiClient;
@property (strong, nonatomic) TLAuthUser *twitterUser;
@property (strong, nonatomic) UIBarButtonItem *postButton;
@property (strong, nonatomic) UIBarButtonItem *cancelButton;
@property (strong, nonatomic) NSMutableDictionary *postParamaters;
@end

@implementation TLTweetEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationItem setTitle:@"New Tweet Post"];
    
    self.navigationItem.leftBarButtonItem = self.cancelButton;
    self.navigationItem.rightBarButtonItem = self.postButton;
    
    [self.view addSubview:[[[NSBundle mainBundle] loadNibNamed:@"TLTweetEditorView" owner:self options:nil] lastObject]];
    
    [self updateUI];
}

- (TLTwitterAPIClient *)apiClient
{
    if (!_apiClient) {
        _apiClient = [TLTwitterAPIClient sharedInstance];
    }
    return _apiClient;
}

- (NSMutableDictionary *)postParamaters
{
    if (!_postParamaters) {
        _postParamaters = [[NSMutableDictionary alloc] init];
    }
    return _postParamaters;
}

- (UIBarButtonItem *)postButton
{
    if (!_postButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(10.0, 2.0, 45.0, 40.0)];
        [button addTarget:self action:@selector(postTweetEditorButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"post" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _postButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    }
    return _postButton;
}

- (UIBarButtonItem *)cancelButton
{
    if (!_cancelButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(10.0, 2.0, 45.0, 40.0)];
        [button addTarget:self action:@selector(cancelEditorButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"X" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _cancelButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    }
    return _cancelButton;
}

- (void)loadDataWithAccount:(TLAuthUser *)account
{
    self.twitterUser = account;
    [self updateUI];
}

- (void)updateUI
{
    [self.editorView.profilePicImageView setImageWithURL:[NSURL URLWithString:self.twitterUser.profileImageURL]];
    self.editorView.delegate = self;
}

- (void)cancelEditorButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)postTweetEditorButtonPressed:(id)sender
{
    if (isAllowedToPost) {
        [self.postParamaters addEntriesFromDictionary:[self getParamaters]];
        [self.apiClient postTweetForAccount:self.twitterUser.twitterAccount WithParamaters:self.postParamaters forView:self.navigationController.view completionHandler:^(TLTweet *tweetPost) {
            [self postedTweet:tweetPost];
        }];
    }
}

- (void)enableEditorToSendTweetPost:(BOOL)enable
{
    isAllowedToPost = enable;
}

- (NSDictionary *)getParamaters
{
    NSDictionary *paramaters = @{@"status":self.editorView.tweetEditorTextView.text};
    return paramaters;
}

- (void)postedTweet:(TLTweet *)tweet
{
    if ([self delegate] && [[self delegate] respondsToSelector:@selector(newPostedTweet:)]) {
        [self.delegate newPostedTweet:tweet];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
