//
//  SelectedApplicationViewController.m
//  AHToolbox
//
//  Created by Tyler Koske on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SelectedApplicationViewController.h"
#import "AFJSONRequestOperation.h"
#import "Application.h"

@interface SelectedApplicationViewController ()

@end

@implementation SelectedApplicationViewController
@synthesize app;
@synthesize labelHolderView;
@synthesize buildCountLabel;
@synthesize errorCountLabel;
@synthesize collaboratorCountLabel;
@synthesize tableview;
@synthesize selectAppLabel;

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
  
    self.title = NSLocalizedString(app.name, app.name);
    
    if ([self.navigationController.parentViewController respondsToSelector:@selector(revealGesture:)] && [self.navigationController.parentViewController respondsToSelector:@selector(revealToggle:)])
    {
      UIPanGestureRecognizer *navigationBarPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.navigationController.parentViewController action:@selector(revealGesture:)];
      [self.navigationController.navigationBar addGestureRecognizer:navigationBarPanGestureRecognizer];
      
      self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Apps", @"Apps") style:UIBarButtonItemStylePlain target:self.navigationController.parentViewController action:@selector(revealToggle:)];
    }
  
  tableview.delegate = self;
  tableview.dataSource = self;
  
  if (app == nil || [app.name length] == 0) {
    [selectAppLabel setHidden:NO];
  } else {
    [labelHolderView setHidden:NO];
  }
  
  HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
  [self.navigationController.view addSubview:HUD];
  HUD.delegate = self;
}

- (void)viewDidUnload
{
  [self setBuildCountLabel:nil];
  [self setErrorCountLabel:nil];
  [self setCollaboratorCountLabel:nil];
  [self setTableview:nil];
  [self setLabelHolderView:nil];
  [self setSelectAppLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)loadApplicationData {
  
}

#pragma mark -
#pragma mark Tableview Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (app == nil || [app.name length] == 0) {
    return 0;
  }
  
  return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *ri = @"ri";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ri];
  
  if(!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ri];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  }
  
  if(app != nil && [app.name length] > 0){
    if (indexPath.row == 0) {
      cell.textLabel.text = @"Builds";
    } else if (indexPath.row == 1) {
      cell.textLabel.text = @"Errors";
    } else if (indexPath.row == 2) {
      cell.textLabel.text = @"Collaborators";
    }
  }
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)addApplication:(id)sender {
}

@end
