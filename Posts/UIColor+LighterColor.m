//
//  UIColor+LighterColor.m
//  Posts
//
//  Created by Anton Rivera on 2/24/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "UIColor+LighterColor.h"

@implementation UIColor (LighterColor)

- (UIColor *)lighterColor
{
    CGFloat h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a]){
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:MIN(b * 1.3, 1.0)
                               alpha:a];
    }
    return nil;
}

@end
