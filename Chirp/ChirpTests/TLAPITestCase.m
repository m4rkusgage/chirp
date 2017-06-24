//
//  TLAPITestCase.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-23.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TLTwitterAPIClient.h"

@interface TLAPITestCase : XCTestCase
@property (strong, nonatomic) TLTwitterAPIClient *apiClient;
@end

@implementation TLAPITestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.apiClient = [TLTwitterAPIClient sharedInstance];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetIOSTwitterAccount
{
    XCTestExpectation *completionExpectation = [self expectationWithDescription:@"Long method"];
    
    [self.apiClient getiOSTwitterAccountForView:[UIView new] completionHandler:^(ACAccount *twitterAccount) {
        
        XCTAssertNotNil(twitterAccount, @"Cannot find Twitter Account");
        XCTAssert([twitterAccount isKindOfClass:[ACAccount class]]);
        
        [completionExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void)testGetProfileInfo
{
    XCTestExpectation *completionExpectation = [self expectationWithDescription:@"Long method"];
    
    [self.apiClient getProfileInfoOfAccount:[self.apiClient getAuthorizedUser].twitterAccount forView:[UIView new] completionHandler:^(TLAuthUser *authUser) {
        
        XCTAssertNotNil(authUser, @"Cannot find Twitter Info");
        
        [completionExpectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void)testGetHomeTimelineTweets
{
    XCTestExpectation *completionExpectation = [self expectationWithDescription:@"Long method"];
    
    [self.apiClient getHomeTimelineForAccount:[self.apiClient getAuthorizedUser].twitterAccount forView:[UIView new] sinceID:@"" completionHandler:^(NSArray *tweets) {
        
        XCTAssertNotNil(tweets, @"Cannot find tweet posts");
        XCTAssert([[tweets firstObject] isKindOfClass:[TLTweet class]]);
        
        [completionExpectation fulfill];
        
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end
