//
//  RPLTableDataSource.m
//  FirstDayDemo
//
//  Created by Richard Lichkus on 1/14/14.
//  Copyright (c) 2014 Codefellows. All rights reserved.
//

#import "RPLTableDataSource.h"
@interface RPLTableDataSource ()

@property (strong, nonatomic) NSMutableArray *studentRoster;
@property (strong, nonatomic) NSMutableArray *teacherRoster;

@end


@implementation RPLTableDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numberOfSections = 2;
    return numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    switch (section)
    {
        case 0:
            numberOfRows = self.teacherRoster.count;
            break;
        case 1:
            numberOfRows = self.studentRoster.count;
            break;
    }
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    switch (indexPath.section)
    {
        case 0:
            cell.textLabel.text = [[self.teacherRoster objectAtIndex:indexPath.row] name];
            break;
        case 1:
            cell.textLabel.text = [[self.studentRoster objectAtIndex:indexPath.row] name];
            break;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"Teachers";
            break;
        case 1:
            sectionName = @"Students";
            break;
    }
    return sectionName;
}


@end
