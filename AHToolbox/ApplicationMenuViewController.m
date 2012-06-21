//
//  ApplicationMenuViewController.m
//  AHToolbox
//
//  Created by Tyler Koske on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ApplicationMenuViewController.h"
#import "Application.h"

@interface ApplicationMenuViewController ()

@end

@implementation ApplicationMenuViewController
@synthesize tableview;
@synthesize applications;

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
    // Do any additional setup after loading the view from its nib.
  
  tableview.delegate = self;
  tableview.dataSource = self;
  
  applications = [[NSMutableArray alloc] init];
}

- (void)viewDidUnload
{
  [self setTableview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
  AHAPIClient *c = [AHAPIClient sharedClient];
  
  [applications addObjectsFromArray:[c retrieveApplications]];
  
  [tableview reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Tableview Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return applications.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *ri = @"ri";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ri];
  
  if(!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ri];
  }
  
  Application *a = (Application*)[applications objectAtIndex:indexPath.row];
  
  cell.textLabel.text = a.name;
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
