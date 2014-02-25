//
//  AHRPostsTableViewController.m
//  Posts
//
//  Created by Anton Rivera on 2/11/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "AHRPostsTableViewController.h"
#import "AHRPost.h"
#import "AHREditPostViewController.h"
#import "UIColor+RandomColor.h"

@interface AHRPostsTableViewController () <AHREditPostViewControllerDelegate>

@end

@implementation AHRPostsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

//    NSDate *date = [NSDate date];
//    
//    NSDictionary *post1Dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Bob", @"userName", @"Bob's First Post", @"title", @"This is my first post.  Hello I'm Bob.", @"content", date, @"timeStamp", [UIColor randomColor], @"postColor", nil];
//    AHRPost *post1 = [[AHRPost alloc] initWithDictionary:post1Dictionary];
//    NSDictionary *post2Dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Sue", @"userName", @"Sue's First Post", @"title", @"This is my first post.  Hello I'm Sue.", @"content", date, @"timeStamp", [UIColor randomColor], @"postColor", nil];
//    AHRPost *post2 = [[AHRPost alloc] initWithDictionary:post2Dictionary];
//    NSDictionary *post3Dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Jack", @"userName", @"Jack's First Post", @"title", @"This is my first post.  Hello I'm Jack.", @"content", date, @"timeStamp", [UIColor randomColor], @"postColor", nil];
//    AHRPost *post3 = [[AHRPost alloc] initWithDictionary:post3Dictionary];
//    NSDictionary *post4Dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Curly", @"userName", @"Curly's First Post", @"title", @"This is my first post.  Hello I'm Curly.", @"content", date, @"timeStamp", [UIColor randomColor], @"postColor", nil];
//    AHRPost *post4 = [[AHRPost alloc] initWithDictionary:post4Dictionary];
//    NSDictionary *post5Dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Moe", @"userName", @"Moe's First Post", @"title", @"This is my first post.  Hello I'm Moe.", @"content", date, @"timeStamp", [UIColor randomColor], @"postColor", nil];
//    AHRPost *post5 = [[AHRPost alloc] initWithDictionary:post5Dictionary];
//    NSDictionary *post6Dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Larry", @"userName", @"Larry's First Post", @"title", @"This is my first post.  Hello I'm Larry.", @"content", date, @"timeStamp", [UIColor randomColor], @"postColor", nil];
//    AHRPost *post6 = [[AHRPost alloc] initWithDictionary:post6Dictionary];
//    NSDictionary *post7Dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Sally", @"userName", @"Sally's First Post", @"title", @"This is my first post.  Hello I'm Sally.", @"content", date, @"timeStamp", [UIColor randomColor], @"postColor", nil];
//    AHRPost *post7 = [[AHRPost alloc] initWithDictionary:post7Dictionary];
//    NSDictionary *post8Dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Ben", @"userName", @"Ben's First Post", @"title", @"This is my first post.  Hello I'm Ben.", @"content", date, @"timeStamp", [UIColor randomColor], @"postColor", nil];
//    AHRPost *post8 = [[AHRPost alloc] initWithDictionary:post8Dictionary];
//    NSDictionary *post9Dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Grace", @"userName", @"Grace's First Post", @"title", @"This is my first post.  Hello I'm Grace.", @"content", date, @"timeStamp", [UIColor randomColor], @"postColor", nil];
//    AHRPost *post9 = [[AHRPost alloc] initWithDictionary:post9Dictionary];
//    NSDictionary *post10Dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"Jill", @"userName", @"Jill's First Post", @"title", @"This is my first post.  Hello I'm Jill.", @"content", date, @"timeStamp", [UIColor randomColor], @"postColor", nil];
//    AHRPost *post10 = [[AHRPost alloc] initWithDictionary:post10Dictionary];
//    
//    self.posts = [NSMutableArray arrayWithObjects:post1, post2, post3, post4, post5, post6, post7, post8, post9, post10, nil];
    
    NSString *filePath = [[self documentsDirectory] stringByAppendingPathComponent:@"Posts.plist"];

    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Posts" ofType:@"plist"];
        [[NSFileManager defaultManager] copyItemAtPath:bundlePath toPath:filePath error:nil];
    }
    self.posts = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:filePath]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger numberOfPosts = [defaults integerForKey:@"number of posts"];
    [defaults setInteger:numberOfPosts+1 forKey:@"number of posts"];
    [defaults synchronize];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self savePostsToDisk];
    [self.tableView reloadData];
}

-(void)savePostsToDisk
{
    NSString *filePath = [[self documentsDirectory] stringByAppendingPathComponent:@"Posts.plist"];
    [NSKeyedArchiver archiveRootObject:self.posts toFile:filePath];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    AHRPost *post = [self.posts objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", post.userName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", post.content];
    cell.backgroundColor = post.postColor;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetailSegue"]) {
        AHREditPostViewController *detail = segue.destinationViewController;
        detail.delegate = self;
        NSInteger selectedRow = [self.tableView indexPathForSelectedRow].row;
        AHRPost *post = [self.posts objectAtIndex:selectedRow];
        detail.post = post;
    } else if ([segue.identifier isEqualToString:@"createPostSeque"]) {
        AHREditPostViewController *detail = segue.destinationViewController;
        AHRPost *post = [AHRPost new];
        detail.post = post;
        post.postColor = [UIColor randomColor];
        [self.posts insertObject:post atIndex:0];
    }
}

- (void)deletePost:(AHRPost *)post
{
    [self.posts removeObject:post];
    [self.tableView reloadData];
}

- (NSString *)documentsDirectory
{
    NSFileManager *filemanager = [NSFileManager defaultManager];
    NSArray *results = [filemanager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsURL = [results lastObject];
    return documentsURL.path;
}


@end
