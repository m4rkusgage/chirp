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
@property (strong, nonatomic) IBOutlet TLTweetEditorView *editorView;
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
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = self.cancelButton;
    self.navigationItem.rightBarButtonItem = self.postButton;
    
    [self.view addSubview:[[[NSBundle mainBundle] loadNibNamed:@"TLTweetEditorView" owner:self options:nil] lastObject]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [button setTitle:@"TWEET" forState:UIControlStateNormal];
        
        _postButton = [[UIBarButtonItem alloc]initWithCustomView:button];
        [_postButton setEnabled:NO];
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
    NSLog(@"LETS POST");
    [self.postParamaters addEntriesFromDictionary:[self getParamaters]];
}

- (void)enableEditorToSendTweetPost:(BOOL)enable
{
    [self.postButton setEnabled:enable];
}

- (NSDictionary *)getParamaters
{
    NSDictionary *paramaters = @{};
    
    return paramaters;
}
@end
