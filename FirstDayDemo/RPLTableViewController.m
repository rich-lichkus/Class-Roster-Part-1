//
//  RPLTableViewController.m
//  FirstDayDemo
//
//  Created by Richard Lichkus on 1/13/14.
//  Copyright (c) 2014 Codefellows. All rights reserved.
//

#import "RPLTableViewController.h"


@interface RPLTableViewController ()

@property (nonatomic, strong) RPLTableDataSource *dataSource;
- (IBAction)sortPressed:(id)sender;


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
    
    self.dataSource= [[RPLTableDataSource  alloc]init];
    self.tableView.dataSource = self.dataSource;

    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Prepare For Seque

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITableViewCell *selectedCell = (UITableViewCell *)sender;
    
    RPLDetailViewController *detailView = segue.destinationViewController;
    
    detailView.title = selectedCell.textLabel.text;
    NSInteger selectedRow = [[self.tableView indexPathForSelectedRow] row];
    NSInteger selectedSection = [[self.tableView indexPathForSelectedRow]section];
    
    if(selectedSection ==0)
    {
        detailView.currentPart = self.dataSource.teacherRoster[selectedRow];
    }
    else if(selectedSection ==1)
    {
        detailView.currentPart = self.dataSource.studentRoster[selectedRow];
    }
}

#pragma mark - IBAction

- (IBAction)sortPressed:(id)sender {
    
    UIActionSheet *sortOptionASheet =  [[UIActionSheet alloc] initWithTitle:@"Sort Options"
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancel"
                                                    destructiveButtonTitle:nil
                                                          otherButtonTitles:@"Ascending", @"Descending", nil];
    [sortOptionASheet showFromBarButtonItem:sender animated:YES];
    
}

#pragma mark - Action Sheet

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if([[actionSheet buttonTitleAtIndex:buttonIndex]isEqualToString:@"Ascending"])
    {
        NSSortDescriptor *ascendingSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        self.dataSource.studentRoster = [NSMutableArray arrayWithArray:[self.dataSource.studentRoster sortedArrayUsingDescriptors:@[ascendingSortDescriptor]]];
        self.dataSource.teacherRoster = [NSMutableArray arrayWithArray:[self.dataSource.teacherRoster sortedArrayUsingDescriptors:@[ascendingSortDescriptor]]];
    }
    else if([[actionSheet buttonTitleAtIndex:buttonIndex]isEqualToString:@"Descending"])
    {
        NSSortDescriptor *descendingSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
        self.dataSource.studentRoster = [NSMutableArray arrayWithArray:[self.dataSource.studentRoster sortedArrayUsingDescriptors:@[descendingSortDescriptor]]];
        self.dataSource.teacherRoster = [NSMutableArray arrayWithArray:[self.dataSource.teacherRoster sortedArrayUsingDescriptors:@[descendingSortDescriptor]]];
    }
    
    [self.tableView reloadData];
}



@end
