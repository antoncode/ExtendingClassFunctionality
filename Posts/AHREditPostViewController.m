//
//  AHREditPostViewController.m
//  Posts
//
//  Created by Anton Rivera on 2/12/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "AHREditPostViewController.h"
#import "AHRPostsTableViewController.h"
#import "UIColor+LighterColor.h"

@interface AHREditPostViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextField *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation AHREditPostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPost:(AHRPost *)post
{
    _post = post;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.userNameLabel.text = _post.userName;
    self.contentTextView.text = _post.content;
    self.navigationItem.title = _post.title;
    self.dateLabel.text = [_post.timeStamp description];
    self.contentTextView.backgroundColor = _post.postColor;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    _post.content = self.contentTextView.text;
    _post.userName = self.userNameLabel.text;
}

- (IBAction)deletePost:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate deletePost:self.post];
}

- (IBAction)makeColorLighter:(id)sender
{
    UIColor *baseColor = _post.postColor;
    UIColor *lighterColor = [baseColor lighterColor];
    self.contentTextView.backgroundColor = lighterColor;
}


@end
