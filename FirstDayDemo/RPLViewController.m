//
//  RPLViewController.m
//  FirstDayDemo
//
//  Created by Richard Lichkus on 1/13/14.
//  Copyright (c) 2014 Codefellows. All rights reserved.
//

#import "RPLViewController.h"

@interface RPLViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView; // iboutlet - weak (storyboard is strong)
@property (strong, nonatomic) NSArray *myStudentsArray;

// referencing
// weak
// strong

// nonatomic - not thread safe
// thread safe - order or access important
// main thread - ui - (long network calls would lock up the ui)
@end

@implementation RPLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // setup before ui loads
    
    NSString *student1 = [NSString stringWithFormat:@"Brad"];
    NSString *student2 = [NSString stringWithFormat:@"Clem"];
    NSString *student3 = [NSString stringWithFormat:@"Billy Bob"];
    // Alt format
    NSString *student4 = @"john";
    
    NSArray *studentArray = [NSArray arrayWithObjects:student1,student2,student3, student4, nil];
    // Alt - NSArray *studentArray = @[student1,student2,student3];
    
    self.myStudentsArray = studentArray;
    
    // dot notation only for propertyies
    // table - needs a delegate and datasource
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myStudentsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.myStudentsArray objectAtIndex:indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
