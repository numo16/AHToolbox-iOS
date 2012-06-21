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
    _sharedClient = [[AHAPIClient alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithCString:kAH_BASE_URL encoding:NSUTF8StringEncoding]]];
  });
  
  return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
  self = [super initWithBaseURL:url];
  
  if(!self)
    return nil;
  
  [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
  
  [self setDefaultHeader:@"Accept" value:@"application/json"];
  
  NSLog(@"Intializing APIClient");
  
  return self;
}

- (void)startAuthorize {
  NSLog(@"Starting authorization");
  
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/user/authorizations/new?client_id=%@&redirect_uri=%@", [NSString stringWithCString:kAH_BASE_URL encoding:NSUTF8StringEncoding], [NSString stringWithCString:kAH_CLIENT_ID encoding:NSUTF8StringEncoding], [NSString stringWithCString:kAH_REDIRECT encoding:NSUTF8StringEncoding]]];
  
  BOOL result = [[UIApplication sharedApplication] openURL:url];
  if (!result) {
    NSLog(@"*** %s: cannot open url \"%@\"", __PRETTY_FUNCTION__, url);
  }
}

- (BOOL)handleOpenURL:(NSURL *)url {
  URLParser *parser = [[URLParser alloc] initWithUrlString:[url absoluteString]];
  code = [parser valueForVariable:@"code"];
  
  NSLog(@"Returned code: %@", code);
  
  NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithCString:kAH_CLIENT_ID encoding:NSUTF8StringEncoding], @"client_id", [NSString stringWithCString:kAH_SECRET_KEY encoding:NSUTF8StringEncoding], @"client_secret", code, @"code", nil];
  
  [self postPath:@"/tokens" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"Reponse: %@", responseObject);
    [NotificationCenter postNotificationName:@"AHAuthenticationPass" object:self];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Error: %@", error);
    [NotificationCenter postNotificationName:@"AHAuthenticationFail" object:self];
  }];
  
  return YES;
}

@end
