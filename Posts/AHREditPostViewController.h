//
//  AHRCreatePostViewController.h
//  Posts
//
//  Created by Anton Rivera on 2/12/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AHRPost.h"

@protocol AHREditPostViewControllerDelegate <NSObject>
@required
- (void)deletePost:(AHRPost *)post;

@end

@interface AHREditPostViewController : UIViewController

@property (nonatomic, weak) AHRPost *post;
@property (nonatomic, unsafe_unretained) id <AHREditPostViewControllerDelegate> delegate;

@end
