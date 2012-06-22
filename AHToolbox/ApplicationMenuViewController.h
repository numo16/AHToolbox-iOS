//
//  ApplicationMenuViewController.h
//  AHToolbox
//
//  Created by Tyler Koske on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplicationMenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (strong, nonatomic) NSMutableArray *applications;

- (IBAction)addApplication:(id)sender;
@end
