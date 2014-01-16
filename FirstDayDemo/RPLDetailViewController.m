//
//  RPLDetailViewController.m
//  FirstDayDemo
//
//  Created by Richard Lichkus on 1/14/14.
//  Copyright (c) 2014 Codefellows. All rights reserved.
//

#import "RPLDetailViewController.h"

@interface RPLDetailViewController ()
- (IBAction)btnPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation RPLDetailViewController

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
    
    NSString *participantName = [NSString stringWithFormat:@"%@.png", self.currentPart.name];
    NSURL *docPath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSString *imagePath = [[docPath path] stringByAppendingString:participantName];
    NSData *pickData = [NSData dataWithContentsOfFile:imagePath];
    
    if(pickData)
    {
        self.imageView.image = [UIImage imageWithData:pickData];
        self.imageView.layer.cornerRadius = 50.0f;
        self.imageView.layer.masksToBounds = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)btnPressed:(id)sender {
    UIActionSheet *photoActionSheet = [[UIActionSheet alloc] initWithTitle:@"Add Photo"
                                                                  delegate:self
                                                         cancelButtonTitle:@"Cancel"
                                                    destructiveButtonTitle:nil
                                                         otherButtonTitles:@"Camera",@"Photo Library", nil];
    [photoActionSheet showFromBarButtonItem:sender animated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *myPicker = [[UIImagePickerController alloc]init];
    myPicker.delegate = self;
    myPicker.allowsEditing = YES;

    if([[actionSheet buttonTitleAtIndex:buttonIndex]isEqualToString:@"Camera"])
    {
        myPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if([[actionSheet buttonTitleAtIndex:buttonIndex]isEqualToString:@"Photo Library"])
    {
        myPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:myPicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *croppedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:^{
       
        NSString *participantName = [NSString stringWithFormat:@"%@.png", self.currentPart.name];
        NSData *pngData = UIImagePNGRepresentation(croppedImage);
        
        NSURL *docPath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSString *imagePath = [[docPath path] stringByAppendingPathComponent:participantName];
        [pngData writeToFile:imagePath atomically:YES];
        
        NSLog(@"%@", imagePath);
        self.imageView.image = croppedImage;
        self.imageView.layer.cornerRadius = 50.0f;
        self.imageView.layer.masksToBounds = YES;
    }];
    
}



@end
