//
//  TLStringCategoryTest.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-23.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+TLUtilities.h"

@interface TLStringCategoryTest : XCTestCase

@end

@implementation TLStringCategoryTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testConvertTimeToInterval
{
    NSString *twitterDateInTwitterFormat = @"Mon Mar 12 01:28:01 +0000 2007";
    NSString *expectedTimeInterval = @"10y";
    
    NSString *resultInterval = [NSString getTweetTimeIntervalString:twitterDateInTwitterFormat];
    
    XCTAssert([resultInterval isEqualToString:expectedTimeInterval]);
}
@end
