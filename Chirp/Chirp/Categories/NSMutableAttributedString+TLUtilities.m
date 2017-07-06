//
//  NSMutableAttributedString+TLUtilities.m
//  Chirp
//
//  Created by Mark Gage on 2017-07-06.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "NSMutableAttributedString+TLUtilities.h"
#import <UIKit/UIKit.h>

@implementation NSMutableAttributedString (TLUtilities)

+ (NSMutableAttributedString *)decorateWithTags:(NSString *)string
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"((?:#|@)\\w+|http\\S+)"
                                                                           options:0
                                                                             error:&error];
    
    NSArray *matches = [regex matchesInString:string
                                      options:0
                                        range:NSMakeRange(0, string.length)];
    
    for (NSTextCheckingResult *match in matches) {
        
        NSRange wordRange = [match rangeAtIndex:1];
        UIColor *tagColor = [UIColor colorWithRed:(89.0/255.0)
                                            green:(192.0/255.0)
                                             blue:(227.0/255.0)
                                            alpha:1.0];
        
        [attributedString addAttribute:NSForegroundColorAttributeName value:tagColor range:wordRange];
    }
    
    return attributedString;
}

@end
