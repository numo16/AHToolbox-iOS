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
#import "Build.h"
#import "Error.h"
#import "Collaborator.h"

@interface SelectedApplicationViewController ()

@end

@implementation SelectedApplicationViewController
@synthesize app, builds, errors, collaborators;
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
  
  HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
  [self.navigationController.view addSubview:HUD];
  HUD.delegate = self;
  
  if (app == nil || [app.name length] == 0) {
    [selectAppLabel setHidden:NO];
  } else {
    [labelHolderView setHidden:NO];
    
    [HUD show:YES];
    [self loadApplicationData];
  }
  
  
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
  [self retrieveBuilds];
  [self retrieveErrors];
  [self retrieveCollaborators];
}

- (void)retrieveBuilds {
  NSMutableArray *array = [[NSMutableArray alloc] init];
  
  NSString *t = [UserDefaults stringForKey:@"oauth_token"];
  
  NSString *urlString = [NSString stringWithFormat:@"%@/applications/%@/builds",[NSString stringWithCString:kAH_BASE_URL encoding:NSUTF8StringEncoding], app.slug];
  
  NSLog(@"Request URL: %@", urlString);
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
  [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
  [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  [request setValue:[NSString stringWithFormat:@"BEARER %@", t] forHTTPHeaderField:@"Authorization"];
  
  AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
    
    NSLog(@"Response: %@", JSON);
    
    for(NSDictionary *dict in JSON){
      [array addObject:[Build objectWithDictionary:dict]];
    }
    
    builds = [NSMutableArray arrayWithArray:array];
    
    buildCountLabel.text = [NSString stringWithFormat:@"%i", [builds count]];
    
  } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
    [MKInfoPanel showPanelInWindow:[ApplicationDelegate window] type:MKInfoPanelTypeError title:@"Builds Retrieval Error" subtitle:@"Unable to retrieve builds"];
    NSLog(@"Error: %@", error);
  }];
  
  [operation start];
}

- (void)retrieveErrors {
  NSMutableArray *array = [[NSMutableArray alloc] init];
  
  NSString *t = [UserDefaults stringForKey:@"oauth_token"];
  
  NSString *urlString = [NSString stringWithFormat:@"%@/applications/%@/errors",[NSString stringWithCString:kAH_BASE_URL encoding:NSUTF8StringEncoding], app.slug];
  
  NSLog(@"Request URL: %@", urlString);
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
  [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
  [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  [request setValue:[NSString stringWithFormat:@"BEARER %@", t] forHTTPHeaderField:@"Authorization"];
  
  AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
    
    NSLog(@"Response: %@", JSON);
    
    for(NSDictionary *dict in JSON){
      [array addObject:[Error objectWithDictionary:dict]];
    }
    
    errors = [NSMutableArray arrayWithArray:array];
    
    errorCountLabel.text = [NSString stringWithFormat:@"%i", [errors count]];
    
  } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
    [MKInfoPanel showPanelInWindow:[ApplicationDelegate window] type:MKInfoPanelTypeError title:@"Errors Retrieval Error" subtitle:@"Unable to retrieve errors"];
    NSLog(@"Error: %@", error);
  }];
  
  [operation start];
}

- (void)retrieveCollaborators {
  NSMutableArray *array = [[NSMutableArray alloc] init];
  
  NSString *t = [UserDefaults stringForKey:@"oauth_token"];
  
  NSString *urlString = [NSString stringWithFormat:@"%@/applications/%@/collaborators",[NSString stringWithCString:kAH_BASE_URL encoding:NSUTF8StringEncoding], app.slug];
  
  NSLog(@"Request URL: %@", urlString);
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
  [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
  [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  [request setValue:[NSString stringWithFormat:@"BEARER %@", t] forHTTPHeaderField:@"Authorization"];
  
  AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
    
    NSLog(@"Response: %@", JSON);
    
    for(NSDictionary *dict in JSON){
      [array addObject:[Collaborator objectWithDictionary:dict]];
    }
    
    collaborators = [NSMutableArray arrayWithArray:array];
    
    collaboratorCountLabel.text = [NSString stringWithFormat:@"%i", [collaborators count]];
    
    [HUD hide:YES];
    
  } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
    [MKInfoPanel showPanelInWindow:[ApplicationDelegate window] type:MKInfoPanelTypeError title:@"Collaborator Retrieval Error" subtitle:@"Unable to retrieve collaborators"];
    NSLog(@"Error: %@", error);
  }];
  
  [operation start];
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
