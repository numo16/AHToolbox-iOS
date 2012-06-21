//
//  AHAPIClient.m
//  AHToolbox
//
//  Created by Tyler Koske on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AHAPIClient.h"
#import "AFJSONRequestOperation.h"
#import "URLParser.h"
#import "AFOAuth2Client.h"

@implementation AHAPIClient
@synthesize code;

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

- (void)startAuthorize {
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/user/authorizations/new?client_id=%@&redirect_uri=%@", kAH_BASE_URL, kAH_CLIENT_ID, kAH_REDIRECT]];
  
  BOOL result = [[UIApplication sharedApplication] openURL:url];
  if (!result) {
    NSLog(@"*** %s: cannot open url \"%@\"", __PRETTY_FUNCTION__, url);
  }
}

- (BOOL)handleOpenURL:(NSURL *)url {
  URLParser *parser = [[URLParser alloc] initWithUrlString:[url absoluteString]];
  code = [parser valueForVariable:@"code"];
  
  __block BOOL success = YES;
  
  NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:kAH_CLIENT_ID, @"client_id", kAH_SECRET_KEY, @"client_secret", code, @"code", nil];
  
  [self postPath:@"/tokens" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"Reponse: %@", responseObject);
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Error: %@", error);
    success = NO;
  }];
  
  return success;
}

@end
