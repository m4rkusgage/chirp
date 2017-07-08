//
//  NSString+TLUtilities.m
//  Chirp
//
//  Created by Mark Gage on 2017-06-23.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "NSString+TLUtilities.h"

@implementation NSString (TLUtilities)

+ (NSString *)getTweetTimeIntervalString:(NSString *)tweetTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setDateFormat: @"EEE MMM dd HH:mm:ss Z yyyy"];
    
    NSDate *date = [dateFormatter dateFromString:tweetTime];
    NSDate *now = [NSDate date];
    
    NSTimeInterval seconds = [now timeIntervalSinceDate:date];
    
    if(seconds < 60) {
        return [[NSString alloc] initWithFormat:@"%.0fs", seconds];
    }
    else if(seconds < 3600) {
        return [[NSString alloc] initWithFormat:@"%.0fm", seconds/60];
    }
    else if(seconds < 3600 * 24) {
        return [[NSString alloc] initWithFormat:@"%.0fh", seconds/3600];
    }
    else if(seconds < 3600 * 24 * 365) {
        return [[NSString alloc] initWithFormat:@"%.0fd", seconds/3600/24];
    }
    else {
        return [[NSString alloc] initWithFormat:@"%.0fy", seconds/3600/24/365];
    }
}

+ (NSString *)removeSuffixString:(NSString *)suffix fromString:(NSMutableString *)string
{
    NSString *suffixFreeString = [string stringByReplacingOccurrencesOfString:suffix
                                                                   withString:@""];
    return suffixFreeString;
}
@end
