//
//  BuildsViewController.h
//  AHToolbox
//
//  Created by Tyler Koske on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuildsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *builds;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end
