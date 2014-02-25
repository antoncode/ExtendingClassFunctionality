//
//  AHRPosts.m
//  Posts
//
//  Created by Anton Rivera on 2/11/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "AHRPost.h"

@implementation AHRPost

- (id) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        self.userName = [dictionary objectForKey:@"userName"];
        self.title = [dictionary objectForKey:@"title"];
        self.content = [dictionary objectForKey:@"content"];
        self.timeStamp = [dictionary objectForKey:@"timeStamp"];
        self.postColor = [dictionary objectForKey:@"postColor"];
    }
    
    return self;
}

// writing to disk
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.userName forKey:@"userName"];
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.content forKey:@"content"];
    [encoder encodeObject:self.timeStamp forKey:@"timeStamp"];
    [encoder encodeObject:self.postColor forKey:@"color"];
}

// reading from disk
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.userName = [decoder decodeObjectForKey:@"userName"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.content = [decoder decodeObjectForKey:@"content"];
        self.timeStamp = [decoder decodeObjectForKey:@"timeStamp"];
        self.postColor = [decoder decodeObjectForKey:@"color"];
    }
    return self;
}



//- (NSString *) formattedDate {
//    NSDateFormatter *timeStampFormatter = [[NSDateFormatter alloc] init];
//    [timeStampFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *tempTimeStamp = [timeStampFormatter dateFromString:self.timeStamp];
//    
//    [timeStampFormatter setDateFormat:@"EE MMM, dd"];
//    return [timeStampFormatter stringFromDate:tempTimeStamp];
//}

@end
