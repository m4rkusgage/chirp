//
//  TLLoginViewController.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-21.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "TLLoginViewController.h"
#import "UIKit+AFNetworking.h"
#import "TLHomeTimeLineViewController.h"

@interface TLLoginViewController ()
@property (weak, nonatomic) IBOutlet TLProfileLoginView *loginView;
@property (strong, nonatomic) TLTwitterAPIClient *apiClient;
@property (strong, nonatomic) TLAuthUser *twitterUser;
@end

@implementation TLLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.view addSubview:[[[NSBundle mainBundle] loadNibNamed:@"TLProfileLoginView" owner:self options:nil] lastObject]];
    
    [self.loginView.userScreenNameLabel setText:[NSString stringWithFormat:@"@%@",self.twitterUser.userScreenName]];
    [self.loginView.loginButton setTitle:[[NSString stringWithFormat:@"Log in as %@",self.twitterUser.userName] uppercaseString] forState:UIControlStateNormal];
    [self.loginView.profileImageView setImageWithURL:[NSURL URLWithString:self.twitterUser.profileImageURL]];
    
    self.loginView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
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
}

- (void)loginButtonWasPressed:(UIButton *)button
{
    [self.apiClient login];
    TLHomeTimeLineViewController *homeTimeLineController = [[TLHomeTimeLineViewController alloc] init];
    [self.navigationController pushViewController:homeTimeLineController animated:YES];
}
@end
