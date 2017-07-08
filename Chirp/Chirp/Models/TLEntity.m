//
//  TLEntity.m
//  Chirp
//
//  Created by Mark Gage on 2017-07-07.
//  Copyright © 2017 Mark Gage. All rights reserved.
//

#import "TLEntity.h"

@interface TLEntity ()

@end

@implementation TLEntity

- (instancetype)initWithEntityType:(TLEntityType)type
{
    self = [self init];
    if (self) {
        _entityType = type;
    }
    return self;
}


- (void)setDataWith:(NSDictionary *)dictionary
{
    switch (self.entityType) {
        case TLEntityTypePhoto:
            self.mediaURLString = dictionary[@"media_url_https"];
            break;
            
        case TLEntityTypeVideo:
            self.mediaURLString = dictionary[@"media_url_https"];
            self.videoURLString = [dictionary[@"video_info"][@"variants"] objectAtIndex:0][@"url"];
            break;
            
        default:
            break;
    }
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.entityType = [decoder decodeIntegerForKey:@"entityType"];
        self.entityID = [decoder decodeObjectForKey:@"entityID"];
        self.urlString = [decoder decodeObjectForKey:@"urlString"];
        self.mediaURLString = [decoder decodeObjectForKey:@"mediaURLString"];
        self.videoURLString = [decoder decodeObjectForKey:@"videoURLString"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInteger:_entityType forKey:@"entityType"];
    [encoder encodeObject:_entityID forKey:@"entityID"];
    [encoder encodeObject:_urlString forKey:@"urlString"];
    [encoder encodeObject:_mediaURLString forKey:@"mediaURLString"];
    [encoder encodeObject:_videoURLString forKey:@"videoURLString"];
}

@end
