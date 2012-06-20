//
//  AHAPIClient.m
//  AHToolbox
//
//  Created by Tyler Koske on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AHAPIClient.h"
#import "AFJSONRequestOperation.h"
#import "AFOAuth2Client.h"

@implementation AHAPIClient

+ (AHAPIClient *)sharedClient {
  static AHAPIClient* _sharedClient = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedClient = [[AHAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kAH_BASE_URL]];
  });
  
  return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
  self = [super initWithBaseURL:url];
  
  if(!self)
    return nil;
  
  [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
  
  [self setDefaultHeader:@"Accept" value:@"application/json"];
  
  return self;
}

- (BOOL)authenticateUserWithCode:(NSString *)code {
  return YES;
}

@end
