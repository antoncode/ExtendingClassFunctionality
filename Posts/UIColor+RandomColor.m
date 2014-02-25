//
//  UIColor+RandomColor.m
//  Posts
//
//  Created by Anton Rivera on 2/20/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "UIColor+RandomColor.h"

@implementation UIColor (RandomColor)

+ (UIColor *)randomColor
{
    CGFloat r = (float)arc4random_uniform(100) / 100;
    CGFloat g = (float)arc4random_uniform(100) / 100;
    CGFloat b = (float)arc4random_uniform(100) / 100;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:0.3];
}

@end
