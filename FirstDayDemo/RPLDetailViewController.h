//
//  RPLDetailViewController.h
//  FirstDayDemo
//
//  Created by Richard Lichkus on 1/14/14.
//  Copyright (c) 2014 Codefellows. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Participant.h"
#import "RPLTableDataSource.h"

@interface RPLDetailViewController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) Participant *currentPart;


- (void) updateBackground;
@end
