//
//  ErrorsViewController.h
//  AHToolbox
//
//  Created by Tyler Koske on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ErrorsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *errors;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end
