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

@interface TLTweetEditorViewController ()
@property (strong, nonatomic) IBOutlet TLTweetEditorView *editorView;
@property (strong, nonatomic) TLTwitterAPIClient *apiClient;
@property (strong, nonatomic) TLAuthUser *twitterUser;
@end

@implementation TLTweetEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationItem setTitle:@"New Tweet Post"];
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(10.0, 2.0, 45.0, 40.0)];
    [button addTarget:self action:@selector(cancelEditorButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"X" forState:UIControlStateNormal];
    UIBarButtonItem *button1 = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = button1;
    
    /*
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(10.0, 2.0, 45.0, 40.0)];
    [button addTarget:self action:@selector(showProfileOpitions:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"profile_setting_img.png"] forState:UIControlStateNormal];
    UIBarButtonItem *button1 = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = button1;*/
    
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

- (void)loadDataWithAccount:(TLAuthUser *)account
{
    self.twitterUser = account;
    [self updateUI];
}

- (void)updateUI
{
    [self.editorView.profilePicImageView setImageWithURL:[NSURL URLWithString:self.twitterUser.profileImageURL]];
}

- (void)cancelEditorButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
