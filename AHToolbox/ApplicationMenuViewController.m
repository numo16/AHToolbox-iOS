//
//  ApplicationMenuViewController.m
//  AHToolbox
//
//  Created by Tyler Koske on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ApplicationMenuViewController.h"
#import "Application.h"
#import "RevealViewController.h"
#import "SelectedApplicationViewController.h"

@interface ApplicationMenuViewController ()
- (void)getUser;
- (void)loadApplications;
- (RevealViewController*)getRevealViewController;
- (SelectedApplicationViewController*)getFrontViewController;
@end

@implementation ApplicationMenuViewController
@synthesize tableview;
@synthesize userLabel;
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

    ShowNetworkActivityIndicator();
  
    [self getUser];
    [self loadApplications];
    
}

- (void)viewDidUnload
{
  [self setTableview:nil];
  [self setUserLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)getUser {
  NSString *t = [UserDefaults stringForKey:@"oauth_token"];
  
  NSString *urlString = [NSString stringWithFormat:@"%@/user",[NSString stringWithCString:kAH_BASE_URL encoding:NSUTF8StringEncoding], t];
  
  NSLog(@"Request URL: %@", urlString);
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
  [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
  [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  [request setValue:[NSString stringWithFormat:@"BEARER %@", t] forHTTPHeaderField:@"Authorization"];
  
  AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
    
    NSLog(@"Response: %@", JSON);
    
    NSString *user = [JSON valueForKey:@"username"];
    
    userLabel.text = [NSString stringWithFormat:@"%@", user];
    
  } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
    [MKInfoPanel showPanelInWindow:[ApplicationDelegate window] type:MKInfoPanelTypeError title:@"Application Retrieval Error" subtitle:@"Unable to retrieve applications"];
    NSLog(@"Error: %@", error);
  }];
  
  [operation start];
}

- (void)loadApplications {
  NSMutableArray *array = [[NSMutableArray alloc] init];
  
  NSString *t = [UserDefaults stringForKey:@"oauth_token"];
  
  NSString *urlString = [NSString stringWithFormat:@"%@/applications",[NSString stringWithCString:kAH_BASE_URL encoding:NSUTF8StringEncoding], t];
  
  NSLog(@"Request URL: %@", urlString);
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
  [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
  [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  [request setValue:[NSString stringWithFormat:@"BEARER %@", t] forHTTPHeaderField:@"Authorization"];
  
  AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
    
    NSLog(@"Response: %@", JSON);
    
    for(NSDictionary *dict in JSON) {
      [array addObject:[Application fromDict:dict]];
    }
    
    NSLog(@"Number of apps: %i", [array count]);
    
    applications = [NSMutableArray arrayWithArray:array];
    [tableview reloadData];
    
  } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
    [MKInfoPanel showPanelInWindow:[ApplicationDelegate window] type:MKInfoPanelTypeError title:@"Application Retrieval Error" subtitle:@"Unable to retrieve applications"];
    NSLog(@"Error: %@", error);
  }];
  
  [operation start];
}

- (RevealViewController*)getRevealViewController {
  RevealViewController *revealController = [self.parentViewController isKindOfClass:[RevealViewController class]] ? (RevealViewController *)self.parentViewController : nil;
  
  return revealController;
}

- (SelectedApplicationViewController*)getFrontViewController {
  RevealViewController *revealController = [self.parentViewController isKindOfClass:[RevealViewController class]] ? (RevealViewController *)self.parentViewController : nil;
  
  if ([revealController.frontViewController isKindOfClass:[UINavigationController class]] && [((UINavigationController *)revealController.frontViewController).topViewController isKindOfClass:[SelectedApplicationViewController class]]){
    SelectedApplicationViewController *front = (SelectedApplicationViewController*)((UINavigationController *) revealController.frontViewController).topViewController;
    
    return front;
  }
  
  return nil;
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
  
  cell.textLabel.text = [a valueForKey:@"name"];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)addApplication:(id)sender {
}
@end
