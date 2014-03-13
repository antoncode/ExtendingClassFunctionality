//
//  AHRPosts.h
//  Posts
//
//  Created by Anton Rivera on 2/11/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AHRPost : NSObject <NSCoding>

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSDate *timeStamp;
@property (nonatomic, strong) UIColor *postColor;
@property (nonatomic, strong) UIImage *photo;

- (id) initWithDictionary:(NSDictionary *)dictionary;

//- (NSString *) formattedDate;

@end
