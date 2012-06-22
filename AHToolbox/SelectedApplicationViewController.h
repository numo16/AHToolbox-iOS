//
//  SelectedApplicationViewController.h
//  AHToolbox
//
//  Created by Tyler Koske on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Application;

@interface SelectedApplicationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MBProgressHUDDelegate> {
  MBProgressHUD *HUD;
}

@property (nonatomic, strong) Application *app;
@property (weak, nonatomic) IBOutlet UIView *labelHolderView;
@property (weak, nonatomic) IBOutlet UILabel *buildCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *errorCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *collaboratorCountLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *selectAppLabel;

- (void)loadApplicationData;

@end
