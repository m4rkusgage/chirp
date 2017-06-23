//
//  TLTweetPostDelegate.h
//  Chirp
//
//  Created by Mark Gage on 2017-06-23.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TLTweetPostDelegate <NSObject>

@optional
- (void)composeTweetWasPressed;
- (void)enableEditorToSendTweetPost:(BOOL)enable;

@end
