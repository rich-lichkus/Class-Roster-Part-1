//
//  RPLTableViewController.m
//  FirstDayDemo
//
//  Created by Richard Lichkus on 1/13/14.
//  Copyright (c) 2014 Codefellows. All rights reserved.
//

#import "RPLTableViewController.h"


@interface RPLTableViewController ()

@property (strong, nonatomic) NSMutableArray *studentRoster;
@property (strong, nonatomic) NSMutableArray *teacherRoster;

@end

@implementation RPLTableViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
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


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITableViewCell *selectedCell = (UITableViewCell *)sender;
    
    RPLDetailViewController *detailView = segue.destinationViewController;
    
    detailView.title = selectedCell.textLabel.text;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
