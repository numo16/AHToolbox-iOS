//
//  NewAppViewController.m
//  AHToolbox
//
//  Created by Tyler Koske on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewAppViewController.h"
#import "AFJSONRequestOperation.h"
#import "JSONKit.h"

@interface NewAppViewController ()

@end

@implementation NewAppViewController
@synthesize appNameField;
@synthesize serverSegmentedControl;

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
  
  self.title = NSLocalizedString(@"New Application", @"New Application");
  
  HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
  [self.navigationController.view addSubview:HUD];
  HUD.delegate = self;
  
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", @"Cancel") style:UIBarButtonItemStylePlain target:self.navigationController.parentViewController action:@selector(cancel)];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"Done") style:UIBarButtonItemStylePlain target:self.navigationController.parentViewController action:@selector(createApplication)];
}

- (void)viewDidUnload
{
    [self setAppNameField:nil];
    [self setServerSegmentedControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)createApplication {
  NSString *name = appNameField.text;
  NSString *region;
  
  switch (serverSegmentedControl.selectedSegmentIndex) {
    case 0:
      region = @"amazon-web-services::us-east-1";
      break;
    
    case 1:
      region = @"amazon-web-services::eu-west-1";
      break;
      
    default:
      region = @"amazon-web-services::us-east-1";
      break;
  }
  
  [appNameField resignFirstResponder];
  
  if ([name length] > 0) {
    NSDictionary *body = [[NSDictionary alloc] initWithObjectsAndKeys:name, @"name", region, @"region_identifier", nil];
    
    NSString *t = [UserDefaults stringForKey:@"oauth_token"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/applications",[NSString stringWithCString:kAH_BASE_URL encoding:NSUTF8StringEncoding], t];
    
    NSLog(@"Request URL: %@", urlString);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:[NSString stringWithFormat:@"BEARER %@", t] forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body JSONData]];
    
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
      
      [HUD hide:YES];
      [self dismissModalViewControllerAnimated:YES];
      
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
      [HUD hide:YES];
      
      [MKInfoPanel showPanelInWindow:[ApplicationDelegate window] type:MKInfoPanelTypeError title:@"Application Creation Error" subtitle:@"Unable to create application"];
      NSLog(@"Error: %@", error);
    }];
    
    [HUD show:YES];
    [operation start];
  } else {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"" message:@"Application name cannot be blank" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
  }
}

- (void)cancel {
  [self dismissModalViewControllerAnimated:YES];
}

@end
