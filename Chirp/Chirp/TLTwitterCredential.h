//
//  TLTwitterCredential.h
//  Chirp
//
//  Created by Mark Gage on 2017-06-20.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLTwitterCredential : NSObject<NSCoding>

@property (copy, nonatomic) NSString *userID;
@property (copy, nonatomic) NSString *userScreenName;
@property (copy, nonatomic) NSString *authToken;
@property (copy, nonatomic) NSString *authTokenSecret;
@property (copy, nonatomic) NSString *verifier;

@end
