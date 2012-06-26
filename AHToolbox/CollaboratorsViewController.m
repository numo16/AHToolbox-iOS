//
//  CollaboratorsViewController.m
//  AHToolbox
//
//  Created by Tyler Koske on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CollaboratorsViewController.h"

@interface CollaboratorsViewController ()

@end

@implementation CollaboratorsViewController
@synthesize tableview, collaborators;

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
  
  self.title = NSLocalizedString(@"Collaborators", @"Collaborators");
}

- (void)viewDidUnload
{
  [self setTableview:nil];
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Tableview Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return collaborators.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *ri = @"ri";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ri];
  
  if(!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ri];
  }
  
  NSMutableDictionary *c = [collaborators objectAtIndex:indexPath.row];
  
  cell.textLabel.text = [[c objectForKey:@"user"] valueForKey:@"name"];
  cell.detailTextLabel.text = [c valueForKey:@"role"];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
