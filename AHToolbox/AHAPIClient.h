//
//  AHAPIClient.h
//  AHToolbox
//
//  Created by Tyler Koske on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface AHAPIClient : AFHTTPClient

@property (nonatomic, strong) NSString* code;

+ (AHAPIClient *)sharedClient;
- (void)startAuthorize;
- (BOOL)handleOpenURL:(NSURL*)url;

@end