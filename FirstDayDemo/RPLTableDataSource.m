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
    
        self.totalRoster = [NSMutableArray new];
        self.studentRoster = [NSMutableArray new];
        self.teacherRoster = [NSMutableArray new];
        NSURL *docPath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSString *archiveRosterPath = [[docPath path] stringByAppendingPathComponent:@"archiveRoster"];
        
        if(![[NSFileManager defaultManager] fileExistsAtPath:archiveRosterPath])
        {
            // Get Info From PList
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
            
            [self.totalRoster addObject:self.teacherRoster];
            [self.totalRoster addObject:self.studentRoster];
            
            [NSKeyedArchiver archiveRootObject:self.totalRoster toFile:archiveRosterPath];
        }
        else {
            self.totalRoster = [NSKeyedUnarchiver unarchiveObjectWithFile:archiveRosterPath];
            
            for(Participant *newPart in self.totalRoster[0])
            {
                [self.teacherRoster addObject:newPart];
            }

            for(Participant *newPart in self.totalRoster[1])
            {
                [self.studentRoster addObject:newPart];
            }
            

        }
        
    }
    return self;
}
    


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numberOfSections = self.totalRoster.count;
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
    
    Participant *eachParticipant = [[Participant alloc]init];
    
    if(indexPath.section == 0)
    {
        cell.textLabel.text = [[self.teacherRoster objectAtIndex:indexPath.row] name];
        
        eachParticipant = self.teacherRoster[indexPath.row];
        NSString *participantImageFileName = [NSString stringWithFormat:@"%@.png", eachParticipant.name];
        eachParticipant = self.teacherRoster[indexPath.row];
        NSURL *docPath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSString *imagePath = [[docPath path] stringByAppendingPathComponent: participantImageFileName];
        NSData *data = [NSData dataWithContentsOfFile:imagePath];
        cell.imageView.image = [UIImage imageWithData:data];
    }
    else if(indexPath.section == 1)
    {
        cell.textLabel.text = [[self.studentRoster objectAtIndex:indexPath.row] name];
        eachParticipant = self.studentRoster[indexPath.row];
        NSString *participantImageFileName = [NSString stringWithFormat:@"%@.png", eachParticipant.name];
        NSURL *docPath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSString *imagePath = [[docPath path] stringByAppendingPathComponent: participantImageFileName];
        NSData *data = [NSData dataWithContentsOfFile:imagePath];
        cell.imageView.image = [UIImage imageWithData:data];
    }
    cell.imageView.layer.cornerRadius = 12.0f;
    cell.imageView.layer.masksToBounds = YES;
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


- (void) archiveData {
    
    NSURL *docPath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSString *archiveRosterPath = [[docPath path] stringByAppendingPathComponent:@"archiveRoster"];
    [NSKeyedArchiver archiveRootObject:self.totalRoster toFile:archiveRosterPath];
    
}




@end
