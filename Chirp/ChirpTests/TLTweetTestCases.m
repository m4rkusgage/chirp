//
//  TLTweetTestCases.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-23.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TLTweet.h"
#import "NSDictionary+JsonUtility.h"

@interface TLTweetTestCases : XCTestCase
@property (strong, nonatomic) TLTweet *tweet;
@end

@implementation TLTweetTestCases

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tweet = [[TLTweet alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreationOfTweet
{
    [self.tweet setDataWith:[NSDictionary tweetDictionary]];
    
    XCTAssertNotNil(self.tweet.tweetID);
    XCTAssertNotNil(self.tweet.tweetText);
    XCTAssertNotNil(self.tweet.tweetPostedAt);
    XCTAssertNotNil(self.tweet.postedByUser);
    
    XCTAssert([self.tweet.postedByUser isKindOfClass:[TLUser class]]);
}

- (void)testAbleToArchiveTweetData
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.tweet];
    XCTAssertNotNil(data);
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"TWEET"];
}

- (void)testRetrievingArchivedTweetData
{
    NSData *tweet = [[NSUserDefaults standardUserDefaults] objectForKey:@"TWEET"];
    XCTAssertNotNil(tweet);
    
    self.tweet = [NSKeyedUnarchiver unarchiveObjectWithData:tweet];
    XCTAssertNotNil(self.tweet);
}

@end
