//
//  Application.h
//  AHToolbox
//
//  Created by Tyler Koske on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AHDomainObject.h"

@interface Application : NSObject <AHDomainObject>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *slug;
@property (nonatomic, retain) NSString *url;

@end
