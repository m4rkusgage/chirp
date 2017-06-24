//
//  NSDictionary+JsonUtility.h
//  Chirp
//
//  Created by Mark Gage on 2017-06-23.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JsonUtility)
+ (NSDictionary *)userDictionary;
+ (NSDictionary *)tweetDictionary;
@end
