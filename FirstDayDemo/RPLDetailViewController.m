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
@property (weak, nonatomic) IBOutlet UITextField *txtTwitter;
@property (weak, nonatomic) IBOutlet UITextField *txtGitHub;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UISlider *sldRed;
@property (weak, nonatomic) IBOutlet UISlider *sldGreen;
@property (weak, nonatomic) IBOutlet UISlider *sldBlue;
@property (weak, nonatomic) RPLTableDataSource *dataSource;

- (IBAction)redSlide:(id)sender;
- (IBAction)greenSlide:(id)sender;
- (IBAction)blueSlide:(id)sender;

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
    NSString *imagePath = [[docPath path] stringByAppendingPathComponent:participantName];
    NSData *pickData = [NSData dataWithContentsOfFile:imagePath];
    NSLog(@"%@",imagePath);
    if(pickData)
    {
        self.imageView.image = [UIImage imageWithData:pickData];
        self.imageView.layer.cornerRadius = 50.0f;
        self.imageView.layer.masksToBounds = YES;
    }
    
    self.sldRed.value = [self.currentPart.favColorRGB[0] floatValue];
    self.sldGreen.value = [self.currentPart.favColorRGB[1] floatValue];
    self.sldBlue.value = [self.currentPart.favColorRGB[2] floatValue];
    
    self.view.backgroundColor = [UIColor colorWithRed:[self.currentPart.favColorRGB[0] floatValue]
                                                green:[self.currentPart.favColorRGB[1] floatValue]
                                                 blue:[self.currentPart.favColorRGB[2] floatValue]
                                                alpha:1.f];
    
    self.txtGitHub.text = self.currentPart.github;
    self.txtTwitter.text = self.currentPart.twitter;
    
    self.scrollView.contentSize =  CGSizeMake(1000,1000);
    self.scrollView.delegate = self;
    self.txtTwitter.delegate = self;
    self.txtGitHub.delegate = self;
    
    //Day 4 - Question #1 - Proof
    NSLog(@"viewDidAppear was called");
}

-(void) viewWillAppear:(BOOL)animated  {
    //Day 4 - Question #1 - Proof
    NSLog(@"viewWillAppear was called");
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

#pragma mark - ActionSheet

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


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.currentPart.twitter = self.txtTwitter.text;
    self.currentPart.github = self.txtGitHub.text;
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)redSlide:(id)sender {
    [self updateBackground];
}

- (IBAction)greenSlide:(id)sender {
    [self updateBackground];
}

- (IBAction)blueSlide:(id)sender {
    [self updateBackground];
}

- (void) updateBackground{
    
    self.view.backgroundColor= [UIColor colorWithRed:self.sldRed.value green:self.sldGreen.value blue:self.sldBlue.value alpha:1.0];
    self.currentPart.favColorRGB = @[[NSNumber numberWithFloat:self.sldRed.value],
                                     [NSNumber numberWithFloat:self.sldGreen.value],
                                     [NSNumber numberWithFloat:self.sldBlue.value]];
    
}


@end
