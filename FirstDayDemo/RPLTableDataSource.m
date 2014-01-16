//
//  RPLTableDataSource.m
//  FirstDayDemo
//
//  Created by Richard Lichkus on 1/14/14.
//  Copyright (c) 2014 Codefellows. All rights reserved.
//

#import "RPLTableDataSource.h"
@interface RPLTableDataSource ()


@end

@implementation RPLTableDataSource

-(id) init {
    self = [super init];
    if(self){
    
        self.studentRoster = [NSMutableArray new];
        self.teacherRoster = [NSMutableArray new];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Bootcamp" ofType:@"plist"];
        NSArray *classRoster = [[NSArray alloc] initWithContentsOfFile:path];
        
        for(NSDictionary *attendee in classRoster)
        {
            Participant *newParticipant = [[Participant alloc] initWithName:[attendee objectForKey:@"name"]];
            newParticipant.isInstructor = [[attendee objectForKey:@"instructor"] boolValue];
            newParticipant.twitter = [attendee objectForKey:@"twitter"];
            newParticipant.github = [attendee objectForKey:@"github"];
            
            if(newParticipant.isInstructor == YES)
            {
                [self.teacherRoster addObject:newParticipant];
            }
            else
            {
                [self.studentRoster addObject:newParticipant];
            }
        }
    
    }
    return self;
}


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
    
    Participant *newPart = [[Participant alloc]init];
    NSString *participantName = [NSString stringWithFormat:@"%@.png", newPart.name];
    
    if(indexPath.section == 0)
    {
        newPart =self.teacherRoster[indexPath.row];
        cell.textLabel.text = [[self.teacherRoster objectAtIndex:indexPath.row] name];
        NSURL *docPath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSString *imagePath = [[docPath path] stringByAppendingPathComponent: participantName];
        NSData *data = [NSData dataWithContentsOfFile:imagePath];
        cell.imageView.image = [UIImage imageWithData:data];
    }
    else if(indexPath.section == 1)
    {
        cell.textLabel.text = [[self.studentRoster objectAtIndex:indexPath.row] name];
        newPart = self.studentRoster[indexPath.row];
        NSURL *docPath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSString *imagePath = [[docPath path] stringByAppendingPathComponent: participantName];
        NSData *data = [NSData dataWithContentsOfFile:imagePath];
        cell.imageView.image = [UIImage imageWithData:data];
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
