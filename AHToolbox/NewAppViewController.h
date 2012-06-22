//
//  NewAppViewController.h
//  AHToolbox
//
//  Created by Tyler Koske on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewAppViewController : UIViewController <MBProgressHUDDelegate> {
  MBProgressHUD *HUD;
}

@property (weak, nonatomic) IBOutlet UITextField *appNameField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *serverSegmentedControl;

- (void)createApplication;
- (void)cancel;
@end
