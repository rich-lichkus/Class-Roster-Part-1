//
//  RPLTableDataSource.h
//  FirstDayDemo
//
//  Created by Richard Lichkus on 1/14/14.
//  Copyright (c) 2014 Codefellows. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Participant.h"
#import "RPLDetailViewController.h"

@interface RPLTableDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *totalRoster;
@property (strong, nonatomic) NSMutableArray *studentRoster;
@property (strong, nonatomic) NSMutableArray *teacherRoster;

-(void)archiveData;

@end
