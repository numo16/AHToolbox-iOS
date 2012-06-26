//
//  SelectedBuildViewController.m
//  AHToolbox
//
//  Created by Tyler Koske on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SelectedBuildViewController.h"
#import "AFJSONRequestOperation.h"
#import "Application.h"

@interface SelectedBuildViewController ()

@end

@implementation SelectedBuildViewController
@synthesize statusLabel;
@synthesize commitMessageTextView, build, app;

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
  
  self.title = [build valueForKey:@"created"];
  statusLabel.text = [build valueForKey:@"status"];
  commitMessageTextView.text = [[build objectForKey:@"commit"] valueForKey:@"message"];
  
  HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
  [self.navigationController.view addSubview:HUD];
  HUD.delegate = self;
}

- (void)viewDidUnload
{
  [self setStatusLabel:nil];
  [self setCommitMessageTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)deployBuild:(id)sender {
  NSString *t = [UserDefaults stringForKey:@"oauth_token"];
  
  NSString *urlString = [NSString stringWithFormat:@"%@/deploy", [build valueForKey:@"url"]];
  
  NSLog(@"Request URL: %@", urlString);
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
  [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
  [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  [request setValue:[NSString stringWithFormat:@"BEARER %@", t] forHTTPHeaderField:@"Authorization"];
  [request setHTTPMethod:@"POST"];
  
  AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
    
    [HUD hide:YES];
    
    if (response.statusCode == 200) {
      [MKInfoPanel showPanelInWindow:[ApplicationDelegate window] type:MKInfoPanelTypeInfo title:@"Build Deployed!" subtitle:@"Build deployed successfully!"];
    }
    
  } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
    [HUD hide:YES];
    
    [MKInfoPanel showPanelInWindow:[ApplicationDelegate window] type:MKInfoPanelTypeError title:@"Build Deployment Error" subtitle:@"Unable to deploy build"];
    NSLog(@"Error: %@", error);
  }];
  
  [HUD show:YES];
  
  [operation start];
}
@end
