//
//  SelectedBuildViewController.h
//  AHToolbox
//
//  Created by Tyler Koske on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Application;

@interface SelectedBuildViewController : UIViewController <MBProgressHUDDelegate> {
  MBProgressHUD *HUD;
}

@property (strong, nonatomic) Application *app;
@property (strong, nonatomic) NSDictionary *build;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UITextView *commitMessageTextView;

- (IBAction)deployBuild:(id)sender;
@end
