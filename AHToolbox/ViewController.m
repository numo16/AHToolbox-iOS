//
//  ViewController.m
//  AHToolbox
//
//  Created by Tyler Koske on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "MKInfoPanel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  
  [NotificationCenter addObserver:self selector:@selector(ahAuthenticationPass) name:@"AHAuthenticationPass" object:nil];
  
  [NotificationCenter addObserver:self selector:@selector(ahAuthenticationFail) name:@"AHAuthenticationFail" object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)ahAuthenticationPass {
  [MKInfoPanel showPanelInView:self.view type:MKInfoPanelTypeInfo title:@"Authentication Success" subtitle:@"Successfully authenticated with App Harbor"];
}

- (void)ahAuthenticationFail {
  [MKInfoPanel showPanelInView:self.view type:MKInfoPanelTypeError title:@"Authentication Failure" subtitle:@"Failed to authenticate with App Harbor"];
}

@end
