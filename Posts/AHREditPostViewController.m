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
#import "Social/Social.h"

@interface AHREditPostViewController () <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextField *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

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
    self.imageView.image = _post.photo;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    _post.content = self.contentTextView.text;
    _post.userName = self.userNameLabel.text;
}

//- (IBAction)deletePost:(id)sender
//{
//    [self.navigationController popViewControllerAnimated:YES];
//    [self.delegate deletePost:self.post];
//}

- (IBAction)sharePost:(id)sender
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *composeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [composeViewController setInitialText:_post.content];
        
        if(_post.photo) {
            [composeViewController addImage:_post.photo];
        }
        
        [self presentViewController:composeViewController animated:YES completion:^{
            NSLog(@"Showing Compose View Controller");
        }];
    } else {
        NSLog(@"Twitter not available");
    }
}

- (IBAction)makeColorLighter:(id)sender
{
    UIColor *baseColor = _post.postColor;
    UIColor *lighterColor = [baseColor lighterColor];
    self.contentTextView.backgroundColor = lighterColor;
}

- (void)showPickerWithSourceType:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *picker = [UIImagePickerController new];
    
    picker.sourceType = sourceType;
    
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    } else {
//        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }

//    UIView *overlay = [[UIView alloc] initWithFrame:CGRectMake(20, 241, 280, 280)];
//    picker.cameraOverlayView = overlay;

    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)takePicture:(id)sender {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose Camera or Photo Library"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Photo Library", @"Camera", nil];
        [actionSheet showFromBarButtonItem:sender animated:YES];
    } else {
        [self showPickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if([buttonTitle isEqualToString:@"Camera"]){
        [self showPickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
    } else if ([buttonTitle isEqualToString:@"Photo Library"]){
        [self showPickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        self.imageView.image = [info objectForKey:UIImagePickerControllerEditedImage];
        
        // Adding a filter
        CIImage *beginImage = [CIImage imageWithCGImage:[self.imageView.image CGImage]];
        CIContext *context = [CIContext contextWithOptions:nil];
        
        CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
                                      keysAndValues:kCIInputImageKey, beginImage, @"inputIntensity", @0.8, nil];
        CIImage *outputImage = [filter outputImage];
        
        CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
        UIImage *newImage = [UIImage imageWithCGImage:cgimg];
        
        self.imageView.image = newImage;
        
        // Display photo as circle
        self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
        self.imageView.clipsToBounds = YES;
        _post.photo = self.imageView.image;
    }];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for(UIControl *control in self.view.subviews)
        if([control isKindOfClass:[UITextField class]]) {
            [control endEditing:YES];
        } else if ([control isKindOfClass:[UITextField class]]){
            [control endEditing:YES];
        }
}











@end
