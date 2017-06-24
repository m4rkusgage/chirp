//
//  TLUserTestCases.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-23.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TLUser.h"
#import "NSDictionary+JsonUtility.h"

@interface TLUserTestCases : XCTestCase
@property (strong, nonatomic) TLUser *user;
@end

@implementation TLUserTestCases

- (void)setUp {
    [super setUp];
    
    self.user = [[TLUser alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreationOfUser
{
    [self.user setDataWith:[NSDictionary userDictionary]];
    
    XCTAssertNotNil(self.user.userID);
    XCTAssertNotNil(self.user.userName);
    XCTAssertNotNil(self.user.userScreenName);
    XCTAssertNotNil(self.user.profileDescription);
    XCTAssertNotNil(self.user.profileImageURL);
    XCTAssertNotNil(self.user.profileBannerURL);
    XCTAssert(self.user.isVerified);
}

- (void)testAbleToArchiveUserData
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.user];
    XCTAssertNotNil(data);
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"USER"];
}

- (void)testRetrievingArchivedUserData
{
    NSData *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER"];
    XCTAssertNotNil(user);
    
    self.user = [NSKeyedUnarchiver unarchiveObjectWithData:user];
    XCTAssertNotNil(self.user);
}



@end
