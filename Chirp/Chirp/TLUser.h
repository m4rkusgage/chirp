//
//  TLUser.h
//  Chirp
//
//  Created by Mark Gage on 2017-06-21.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLUser : NSObject<NSCoding>

@property (assign, nonatomic) BOOL isVerified;
@property (copy, nonatomic) NSString *userID;
@property (copy, nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *userScreenName;
@property (copy, nonatomic) NSString *profileDescription;
@property (copy, nonatomic) NSString *profileImageURL;
@property (copy, nonatomic) NSString *profileBannerURL;

- (void)setDataWith:(NSDictionary *)dictionary;

@end
