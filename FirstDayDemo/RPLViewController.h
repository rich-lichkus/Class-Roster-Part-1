//
//  RPLViewController.h
//  FirstDayDemo
//
//  Created by Richard Lichkus on 1/13/14.
//  Copyright (c) 2014 Codefellows. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPLViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
                                                // <Protocol> - allows class to use methods of the protocal
                                                // Datasource - num rows for data
                                                // Delegate - user tapped on a cell
@end
