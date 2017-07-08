//
//  TLEntity.h
//  Chirp
//
//  Created by Mark Gage on 2017-07-07.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    TLEntityTypeURL,
    TLEntityTypeVideo,
    TLEntityTypePhoto,
    TLEntityTypeMultiPhoto,
    TLEntityTypeGIF
} TLEntityType;

@interface TLEntity : NSObject<NSCoding>

@property (assign, nonatomic) TLEntityType entityType;
@property (copy, nonatomic) NSString *entityID;
@property (copy, nonatomic) NSString *urlString;
@property (copy, nonatomic) NSString *mediaURLString;
@property (copy, nonatomic) NSString *videoURLString;

- (instancetype)initWithEntityType:(TLEntityType)type;
- (void)setDataWith:(NSDictionary *)dictionary;

@end
